class RpexceptionsController < ApplicationController

  def index
    @sel_rpe_type = params[:rpe_type_id]
    if !@sel_rpe_type.nil? and @sel_rpe_type != ""
      @sel_rpe_type = @sel_rpe_type.to_i
    else
      @sel_rpe_type = nil
    end
    @rpexceptions = Rpexception.search(@sel_rpe_type) 
    @rpexceptions = @rpexceptions.paginate(:page => params[:page])
    @rpexception_types = get_exception_types 
 end

  def index_intro
    logger.fatal "Not really fatal - just starting index_intro"
    logger.debug "Something at debug level"
    logger.info "Something at info level"
    @rpexceptions = nil
    @rpexception_types = get_exception_types
    @sel_rpe_type = nil
  end

  def show
    pRel = Rpexception.where(id: params[:id])
    @rpexception = pRel[0]
  end

  def edit
    # byebug
    @rpexception = Rpexception.find(params[:id])
    if !@rpexception.has_base_player
      @new_player = @rpexception.generate_player
    elsif @rpexception.resolved
      @new_player = @rpexception.player
    end
    respond_to do |format|
      # byebug
      format.html
      format.json { @countries = Country.search_text(params[:term]) }
    end
  end

  def update
#    byebug
    update_passed = false
    @rpexception = Rpexception.find(params[:id])
    if !(params["update"].nil? or @rpexception.nil?)
      if params["update"].keys.size > 0
        sel_act = params["update"].keys[0]
        if (sel_act == ":set_to_nationality")
          @rpexception.set_to_nationality
          update_passed = true
        elsif (sel_act == ":keep_player_country")
          @rpexception.keep_player_country
          update_passed = true
        elsif (sel_act == ":update_country_with_nationality")
          @rpexception.update_country_with_nationality
          update_passed = true
        end
      end
    end
    if update_passed
      @sel_rpe_type = @rpexception.rpexception_type.id
      @save_msg = "Update was successful"
    end
  end

  def get_exception_types
    ct_map = Rpexception.where("resolved = false").group(:rpexception_type_id).count
    RpexceptionType.all.collect { | rpe | 
      ct = ct_map[rpe.id]
      if !ct.nil?
        [rpe.desc + " (" + ct.to_s + ")", rpe.id]
      else
        [rpe.desc, rpe.id] 
      end
    }
  end
end
