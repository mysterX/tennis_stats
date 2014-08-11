require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PlayersHelper. For example:
#
# describe PlayersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe PlayersHelper do
  describe "code generation from name" do
    describe "concats standard name to code" do
      before { @code_array = PlayersHelper.name_to_code("Roger Federer") }

      it "should match codes" do
        expect(@code_array).to include("rfede")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Alejandro Aramburu Acuna" do
      before { @code_array = PlayersHelper.name_to_code("Alejandro Aramburu Acuna") }

      it "should match codes" do
        expect(@code_array).to include("aaram")
        expect(@code_array).to include("aaacu")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Alex Bogomolov Jr." do
      before { @code_array = PlayersHelper.name_to_code("Alex Bogomolov Jr.") }

      it "should match codes" do
        expect(@code_array).to include("abogo")
        expect(@code_array).to include("abogo2")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Alessio Di Mauro" do
      before { @code_array = PlayersHelper.name_to_code("Alessio Di Mauro") }

      it "should match codes" do
        expect(@code_array).to include("adima")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Arnaud Di Pasquale" do
      before { @code_array = PlayersHelper.name_to_code("Arnaud Di Pasquale") }

      it "should match codes" do
        expect(@code_array).to include("adipa")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Adriana Serra Zanetti" do
      before { @code_array = PlayersHelper.name_to_code("Adriana Serra Zanetti") }

      it "should match codes" do
        expect(@code_array).to include("aserr")
        expect(@code_array).to include("aszan")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Anna Karolina Schmiedlova" do
      before { @code_array = PlayersHelper.name_to_code("Anna Karolina Schmiedlova") }

      it "should match codes" do
        expect(@code_array).to include("akaro")
        expect(@code_array).to include("aksch")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Anabel Medina Garrigues" do
      before { @code_array = PlayersHelper.name_to_code("Anabel Medina Garrigues") }

      it "should match codes" do
        expect(@code_array).to include("amedi")
        expect(@code_array).to include("amgar")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Antonella Serra Zanetti" do
      before { @code_array = PlayersHelper.name_to_code("Antonella Serra Zanetti") }

      it "should match codes" do
        expect(@code_array).to include("aserr")
        expect(@code_array).to include("aszan")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Alison Van Uytvanck" do
      before { @code_array = PlayersHelper.name_to_code("Alison Van Uytvanck") }

      it "should match codes" do
        expect(@code_array).to include("avanu")
        expect(@code_array).to include("avuyt")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Craig A. Miller" do
      before { @code_array = PlayersHelper.name_to_code("Craig A. Miller") }

      it "should match codes" do
        expect(@code_array).to include("camil")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Carla Suarez Navarro" do
      before { @code_array = PlayersHelper.name_to_code("Carla Suarez Navarro") }

      it "should match codes" do
        expect(@code_array).to include("csuar")
        expect(@code_array).to include("csnav")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Cristina Torrens Valero" do
      before { @code_array = PlayersHelper.name_to_code("Cristina Torrens Valero") }

      it "should match codes" do
        expect(@code_array).to include("ctorr")
        expect(@code_array).to include("ctval")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Christophe Van Garsse" do
      before { @code_array = PlayersHelper.name_to_code("Christophe Van Garsse") }

      it "should match codes" do
        expect(@code_array).to include("cvang")
        expect(@code_array).to include("cvgar")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Christo Van Rensburg" do
      before { @code_array = PlayersHelper.name_to_code("Christo Van Rensburg") }

      it "should match codes" do
        expect(@code_array).to include("cvanr")
        expect(@code_array).to include("cvren")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats David Di Lucia" do
      before { @code_array = PlayersHelper.name_to_code("David Di Lucia") }

      it "should match codes" do
        expect(@code_array).to include("ddilu")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Dianne Van Rensburg" do
      before { @code_array = PlayersHelper.name_to_code("Dianne Van Rensburg") }

      it "should match codes" do
        expect(@code_array).to include("dvanr")
        expect(@code_array).to include("dvren")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Daniel Munoz-De La Nava" do
      before { @code_array = PlayersHelper.name_to_code("Daniel Munoz-De La Nava") }

      it "should match codes" do
        expect(@code_array).to include("dmuno")
        expect(@code_array).to include("dmlan")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Diego Sebastian Schwartzman" do
      before { @code_array = PlayersHelper.name_to_code("Diego Sebastian Schwartzman") }

      it "should match codes" do
        expect(@code_array).to include("dseba")
        expect(@code_array).to include("dssch")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Dennis Van Scheppingen" do
      before { @code_array = PlayersHelper.name_to_code("Dennis Van Scheppingen") }

      it "should match codes" do
        expect(@code_array).to include("dvans")
        expect(@code_array).to include("dvsch")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Erika De Lone" do
      before { @code_array = PlayersHelper.name_to_code("Erika De Lone") }

      it "should match codes" do
        expect(@code_array).to include("edelo")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Eduardo Osta Valenti" do
      before { @code_array = PlayersHelper.name_to_code("Eduardo Osta Valenti") }

      it "should match codes" do
        expect(@code_array).to include("eosta")
        expect(@code_array).to include("eoval")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Filip De Wulf" do
      before { @code_array = PlayersHelper.name_to_code("Filip De Wulf") }

      it "should match codes" do
        expect(@code_array).to include("fdewu")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Gala Leon Garcia" do
      before { @code_array = PlayersHelper.name_to_code("Gala Leon Garcia") }

      it "should match codes" do
        expect(@code_array).to include("gleon")
        expect(@code_array).to include("glgar")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Hao Chen Tang" do
      before { @code_array = PlayersHelper.name_to_code("Hao Chen Tang") }

      it "should match codes" do
        expect(@code_array).to include("hchen")
        expect(@code_array).to include("hctan")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Horacio De La Pena" do
      before { @code_array = PlayersHelper.name_to_code("Horacio De La Pena") }

      it "should match codes" do
        expect(@code_array).to include("hdelap")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Heidi El Tabakh" do
      before { @code_array = PlayersHelper.name_to_code("Heidi El Tabakh") }

      it "should match codes" do
        expect(@code_array).to include("helta")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Hellas Ter Riet" do
      before { @code_array = PlayersHelper.name_to_code("Hellas Ter Riet") }

      it "should match codes" do
        expect(@code_array).to include("hterr")
        expect(@code_array).to include("htrie")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Huub Van Boeckel" do
      before { @code_array = PlayersHelper.name_to_code("Huub Van Boeckel") }

      it "should match codes" do
        expect(@code_array).to include("hvanb")
        expect(@code_array).to include("hvboe")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Inigo Cervantes Huegun" do
      before { @code_array = PlayersHelper.name_to_code("Inigo Cervantes Huegun") }

      it "should match codes" do
        expect(@code_array).to include("icerv")
        expect(@code_array).to include("ichue")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Izak Ven Der Merwe" do
      before { @code_array = PlayersHelper.name_to_code("Izak Ven Der Merwe") }

      it "should match codes" do
        expect(@code_array).to include("ivdme")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jonas B. Svensson" do
      before { @code_array = PlayersHelper.name_to_code("Jonas B. Svensson") }

      it "should match codes" do
        expect(@code_array).to include("jbsve")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Juan Carlos Ferrero" do
      before { @code_array = PlayersHelper.name_to_code("Juan Carlos Ferrero") }

      it "should match codes" do
        expect(@code_array).to include("jcarl")
        expect(@code_array).to include("jcfer")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Jonathan Dasnieres De Veigy" do
      before { @code_array = PlayersHelper.name_to_code("Jonathan Dasnieres De Veigy") }

      it "should match codes" do
        expect(@code_array).to include("jdasn")
        expect(@code_array).to include("jddev")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Jesse Huta Galung" do
      before { @code_array = PlayersHelper.name_to_code("Jesse Huta Galung") }

      it "should match codes" do
        expect(@code_array).to include("jhuta")
        expect(@code_array).to include("jhgal")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Juan Ignacio Chela" do
      before { @code_array = PlayersHelper.name_to_code("Juan Ignacio Chela") }

      it "should match codes" do
        expect(@code_array).to include("jigna")
        expect(@code_array).to include("jiche")
        expect(@code_array.length).to eq(2)
      end
    end

#      expect(PlayersHelper.name_to_code("John-Laffnie De Jager")).to include("jdeja")
#      expect(PlayersHelper.name_to_code("John-Laffnie De Jager")).to include("jldej")
#      expect(PlayersHelper.name_to_code("John-Laffnie De Jager").length).to eq(2)

    describe "concats Juan Martin Del Potro" do
      before { @code_array = PlayersHelper.name_to_code("Juan Martin Del Potro") }

      it "should match codes" do
        expect(@code_array).to include("jmdelp")
        expect(@code_array).to include("jmart")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Johan Van Herck" do
      before { @code_array = PlayersHelper.name_to_code("Johan Van Herck") }

      it "should match codes" do
        expect(@code_array).to include("jvanh")
        expect(@code_array).to include("jvher")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats John Van Lottum" do
      before { @code_array = PlayersHelper.name_to_code("John Van Lottum") }

      it "should match codes" do
        expect(@code_array).to include("jvanl")
        expect(@code_array).to include("jvlot")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Kenny De Schepper" do
      before { @code_array = PlayersHelper.name_to_code("Kenny De Schepper") }

      it "should match codes" do
        expect(@code_array).to include("kdesc")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Lucas Arnold Ker" do
      before { @code_array = PlayersHelper.name_to_code("Lucas Arnold Ker") }

      it "should match codes" do
        expect(@code_array).to include("larno")
        expect(@code_array).to include("laker")
        expect(@code_array.length).to eq(2)
      end
    end

#      expect(PlayersHelper.name_to_code("Miguel-Angel Lopez Jaen")).to include("mlope")
#      expect(PlayersHelper.name_to_code("Miguel-Angel Lopez Jaen")).to include("malop")
#      expect(PlayersHelper.name_to_code("Miguel-Angel Lopez Jaen")).to include("mljae")
#      expect(PlayersHelper.name_to_code("Miguel-Angel Lopez Jaen")).to include("malja")
#      expect(PlayersHelper.name_to_code("Miguel-Angel Lopez Jaen").length).to eq(4)

    describe "concats Mariaan De Swardt" do
      before { @code_array = PlayersHelper.name_to_code("Mariaan De Swardt") }

      it "should match codes" do
        expect(@code_array).to include("mdesw")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Mary Joe Fernandez" do
      before { @code_array = PlayersHelper.name_to_code("Mary Joe Fernandez") }

      it "should match codes" do
        expect(@code_array).to include("mjoef")
        expect(@code_array).to include("mjfer")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Maria Joao Koehler" do
      before { @code_array = PlayersHelper.name_to_code("Maria Joao Koehler") }

      it "should match codes" do
        expect(@code_array).to include("mjoao")
        expect(@code_array).to include("mjkoe")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Maria Jose Martinez Sanchez" do
      before { @code_array = PlayersHelper.name_to_code("Maria Jose Martinez Sanchez") }

      it "should match codes" do
        expect(@code_array).to include("mjose")
        expect(@code_array).to include("mjmar")
        expect(@code_array).to include("mjmsa")
        expect(@code_array.length).to eq(3)
      end
    end

    describe "concats Michelle Larcher De Brito" do
      before { @code_array = PlayersHelper.name_to_code("Michelle Larcher De Brito") }

      it "should match codes" do
        expect(@code_array).to include("mlarc")
        expect(@code_array).to include("mldeb")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Miloslav Mecir Jr" do
      before { @code_array = PlayersHelper.name_to_code("Miloslav Mecir Jr") }

      it "should match codes" do
        expect(@code_array).to include("mmeci")
        expect(@code_array).to include("mmeci2")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Maria Sanchez Lorenzo" do
      before { @code_array = PlayersHelper.name_to_code("Maria Sanchez Lorenzo") }

      it "should match codes" do
        expect(@code_array).to include("msanc")
        expect(@code_array).to include("mslor")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Maria Theresa Torro-Flor" do
      before { @code_array = PlayersHelper.name_to_code("Maria Theresa Torro-Flor") }

      it "should match codes" do
        expect(@code_array).to include("mther")
        expect(@code_array).to include("mttor")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Marianne Van Der Torre" do
      before { @code_array = PlayersHelper.name_to_code("Marianne Van Der Torre") }

      it "should match codes" do
        expect(@code_array).to include("mvdto")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Melle Van Gemerden" do
      before { @code_array = PlayersHelper.name_to_code("Melle Van Gemerden") }

      it "should match codes" do
        expect(@code_array).to include("mvang")
        expect(@code_array).to include("mvgem")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Molly Van Nostrand" do
      before { @code_array = PlayersHelper.name_to_code("Molly Van Nostrand") }

      it "should match codes" do
        expect(@code_array).to include("mvann")
        expect(@code_array).to include("mvnos")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Martin Vassallo Arguello" do
      before { @code_array = PlayersHelper.name_to_code("Martin Vassallo Arguello") }

      it "should match codes" do
        expect(@code_array).to include("mvass")
        expect(@code_array).to include("mvarg")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Nuria Llagostera Vives" do
      before { @code_array = PlayersHelper.name_to_code("Nuria Llagostera Vives") }

      it "should match codes" do
        expect(@code_array).to include("nllag")
        expect(@code_array).to include("nlviv")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Noelle Van Lottum" do
      before { @code_array = PlayersHelper.name_to_code("Noelle Van Lottum") }

      it "should match codes" do
        expect(@code_array).to include("nvanl")
        expect(@code_array).to include("nvlot")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Oscar Hernandez Perez" do
      before { @code_array = PlayersHelper.name_to_code("Oscar Hernandez Perez") }

      it "should match codes" do
        expect(@code_array).to include("ohern")
        expect(@code_array).to include("ohper")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Oscar Martinez Dieguez" do
      before { @code_array = PlayersHelper.name_to_code("Oscar Martinez Dieguez") }

      it "should match codes" do
        expect(@code_array).to include("omart")
        expect(@code_array).to include("omdie")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Pablo Carreno Busta" do
      before { @code_array = PlayersHelper.name_to_code("Pablo Carreno Busta") }

      it "should match codes" do
        expect(@code_array).to include("pcarr")
        expect(@code_array).to include("pcbus")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Rossana De Los Rios" do
      before { @code_array = PlayersHelper.name_to_code("Rossana De Los Rios") }

      it "should match codes" do
        expect(@code_array).to include("rdelr")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Rik De Voest" do
      before { @code_array = PlayersHelper.name_to_code("Rik De Voest") }

      it "should match codes" do
        expect(@code_array).to include("rdevo")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Rogerio Dutra Silva" do
      before { @code_array = PlayersHelper.name_to_code("Rogerio Dutra Silva") }

      it "should match codes" do
        expect(@code_array).to include("rdutr")
        expect(@code_array).to include("rdsil")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Rita Kuti Kis" do
      before { @code_array = PlayersHelper.name_to_code("Rita Kuti Kis") }

      it "should match codes" do
        expect(@code_array).to include("rkuti")
        expect(@code_array).to include("rkkis")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Surina De Beer" do
      before { @code_array = PlayersHelper.name_to_code("Surina De Beer") }

      it "should match codes" do
        expect(@code_array).to include("sdebe")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Sebastien De Chaunac" do
      before { @code_array = PlayersHelper.name_to_code("Sebastien De Chaunac") }

      it "should match codes" do
        expect(@code_array).to include("sdech")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Stephanie De Ville" do
      before { @code_array = PlayersHelper.name_to_code("Stephanie De Ville") }

      it "should match codes" do
        expect(@code_array).to include("sdevi")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Silvia La Fratta" do
      before { @code_array = PlayersHelper.name_to_code("Silvia La Fratta") }

      it "should match codes" do
        expect(@code_array).to include("slafr")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Thiemo De Bakker" do
      before { @code_array = PlayersHelper.name_to_code("Thiemo De Bakker") }

      it "should match codes" do
        expect(@code_array).to include("tdeba")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Tamer El Sawy" do
      before { @code_array = PlayersHelper.name_to_code("Tamer El Sawy") }

      it "should match codes" do
        expect(@code_array).to include("telsa")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Victor Estrella Burgos" do
      before { @code_array = PlayersHelper.name_to_code("Victor Estrella Burgos") }

      it "should match codes" do
        expect(@code_array).to include("vestr")
        expect(@code_array).to include("vebur")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Virginia Ruano Pascual" do
      before { @code_array = PlayersHelper.name_to_code("Virginia Ruano Pascual") }

      it "should match codes" do
        expect(@code_array).to include("vruan")
        expect(@code_array).to include("vrpas")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Younes El Aynaoui" do
      before { @code_array = PlayersHelper.name_to_code("Younes El Aynaoui") }

      it "should match codes" do
        expect(@code_array).to include("yelay")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Yoon Jeong Cho" do
      before { @code_array = PlayersHelper.name_to_code("Yoon Jeong Cho") }

      it "should match codes" do
        expect(@code_array).to include("yjeon")
        expect(@code_array).to include("yjcho")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Na Li" do
      before { @code_array = PlayersHelper.name_to_code("Na Li") }

      it "should match codes" do
        expect(@code_array).to include("nali")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Di Wu" do
      before { @code_array = PlayersHelper.name_to_code("Di Wu") }

      it "should match codes" do
        expect(@code_array).to include("diwu")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Ho Na" do
      before { @code_array = PlayersHelper.name_to_code("Hu Na") }

      it "should match codes" do
        expect(@code_array).to include("huna")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Anne-Gaelle Sidot" do
      before { @code_array = PlayersHelper.name_to_code("Anne-Gaelle Sidot") }

      it "should match codes" do
        expect(@code_array).to include("agsid")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Anna-Lena Friedsam" do
      before { @code_array = PlayersHelper.name_to_code("Anna-Lena Friedsam") }

      it "should match codes" do
        expect(@code_array).to include("alfri")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Anna-Lena Groenefeld" do
      before { @code_array = PlayersHelper.name_to_code("Anna-Lena Groenefeld") }

      it "should match codes" do
        expect(@code_array).to include("algro")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Anna-Maria Fernandez" do
      before { @code_array = PlayersHelper.name_to_code("Anna-Maria Fernandez") }

      it "should match codes" do
        expect(@code_array).to include("amfer")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Anna-Maria Foldenyi" do
      before { @code_array = PlayersHelper.name_to_code("Anna-Maria Foldenyi") }

      it "should match codes" do
        expect(@code_array).to include("amfol")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Bent-Ore Pedersen" do
      before { @code_array = PlayersHelper.name_to_code("Bent-Ore Pedersen") }

      it "should match codes" do
        expect(@code_array).to include("boped")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Bong-Soo Kim" do
      before { @code_array = PlayersHelper.name_to_code("Bong-Soo Kim") }

      it "should match codes" do
        expect(@code_array).to include("bskim")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Chia-Jung Chuang" do
      before { @code_array = PlayersHelper.name_to_code("Chia-Jung Chuang") }

      it "should match codes" do
        expect(@code_array).to include("cjchu")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Cedrik-Marcel Stebe" do
      before { @code_array = PlayersHelper.name_to_code("Cedrik-Marcel Stebe") }

      it "should match codes" do
        expect(@code_array).to include("cmste")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Carl-Uwe Steeb" do
      before { @code_array = PlayersHelper.name_to_code("Carl-Uwe Steeb") }

      it "should match codes" do
        expect(@code_array).to include("custe")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Dee-Ann Hansel" do
      before { @code_array = PlayersHelper.name_to_code("Dee-Ann Hansel") }

      it "should match codes" do
        expect(@code_array).to include("dahan")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Dinu-Mihai Pescariu" do
      before { @code_array = PlayersHelper.name_to_code("Dinu-Mihai Pescariu") }

      it "should match codes" do
        expect(@code_array).to include("dmpes")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Eva-Maria Schurhoff" do
      before { @code_array = PlayersHelper.name_to_code("Eva-Maria Schurhoff") }

      it "should match codes" do
        expect(@code_array).to include("emsch")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Hans-Dieter Beutel" do
      before { @code_array = PlayersHelper.name_to_code("Hans-Dieter Beutel") }

      it "should match codes" do
        expect(@code_array).to include("hdbeu")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Hendrik-Jan Davids" do
      before { @code_array = PlayersHelper.name_to_code("Hendrik-Jan Davids") }

      it "should match codes" do
        expect(@code_array).to include("hjdav")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Hyung-Taik Lee" do
      before { @code_array = PlayersHelper.name_to_code("Hyung-Taik Lee") }

      it "should match codes" do
        expect(@code_array).to include("htlee")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Irina-Camelia Begu" do
      before { @code_array = PlayersHelper.name_to_code("Irina-Camelia Begu") }

      it "should match codes" do
        expect(@code_array).to include("icbeg")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jo-Anne Faull" do
      before { @code_array = PlayersHelper.name_to_code("Jo-Anne Faull") }

      it "should match codes" do
        expect(@code_array).to include("jafau")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Juan-Antonio Marin" do
      before { @code_array = PlayersHelper.name_to_code("Juan-Antonio Marin") }

      it "should match codes" do
        expect(@code_array).to include("jamar")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Juan-Albert Viloca-Puig" do
      before { @code_array = PlayersHelper.name_to_code("Juan-Albert Viloca-Puig") }

      it "should match codes" do
        expect(@code_array).to include("javil")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jean-Baptiste Perlant" do
      before { @code_array = PlayersHelper.name_to_code("Jean-Baptiste Perlant") }

      it "should match codes" do
        expect(@code_array).to include("jbper")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Juan-Carlos Baguena" do
      before { @code_array = PlayersHelper.name_to_code("Juan-Carlos Baguena") }

      it "should match codes" do
        expect(@code_array).to include("jcbag")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jean-Christophe Faurel" do
      before { @code_array = PlayersHelper.name_to_code("Jean-Christophe Faurel") }

      it "should match codes" do
        expect(@code_array).to include("jcfau")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jose-Francisco Altur" do
      before { @code_array = PlayersHelper.name_to_code("Jose-Francisco Altur") }

      it "should match codes" do
        expect(@code_array).to include("jfalt")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jan-Frode Andersen" do
      before { @code_array = PlayersHelper.name_to_code("Jan-Frode Andersen") }

      it "should match codes" do
        expect(@code_array).to include("jfand")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jean-Francois Bachelot" do
      before { @code_array = PlayersHelper.name_to_code("Jean-Francois Bachelot") }

      it "should match codes" do
        expect(@code_array).to include("jfbac")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jose-Luis Clerc" do
      before { @code_array = PlayersHelper.name_to_code("Jose-Luis Clerc") }

      it "should match codes" do
        expect(@code_array).to include("jlcle")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats John-Laffnie De Jager" do
      before { @code_array = PlayersHelper.name_to_code("John-Laffnie De Jager") }

      it "should match codes" do
        expect(@code_array).to include("jldej")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jan-Lennard Struff" do
      before { @code_array = PlayersHelper.name_to_code("Jan-Lennard Struff") }

      it "should match codes" do
        expect(@code_array).to include("jlstr")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Juan-Manuel Balcells" do
      before { @code_array = PlayersHelper.name_to_code("Juan-Manuel Balcells") }

      it "should match codes" do
        expect(@code_array).to include("jmbal")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jan-Michael Gambill" do
      before { @code_array = PlayersHelper.name_to_code("Jan-Michael Gambill") }

      it "should match codes" do
        expect(@code_array).to include("jmgam")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Juan-Pablo Brzezicki" do
      before { @code_array = PlayersHelper.name_to_code("Juan-Pablo Brzezicki") }

      it "should match codes" do
        expect(@code_array).to include("jpbrz")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jean-Philippe Fleurian" do
      before { @code_array = PlayersHelper.name_to_code("Jean-Philippe Fleurian") }

      it "should match codes" do
        expect(@code_array).to include("jpfle")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Juan-Pablo Guzman" do
      before { @code_array = PlayersHelper.name_to_code("Juan-Pablo Guzman") }

      it "should match codes" do
        expect(@code_array).to include("jpguz")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats John-Patrick Smith" do
      before { @code_array = PlayersHelper.name_to_code("John-Patrick Smith") }

      it "should match codes" do
        expect(@code_array).to include("jpsmi")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jing-Qian Yi" do
      before { @code_array = PlayersHelper.name_to_code("Jing-Qian Yi") }

      it "should match codes" do
        expect(@code_array).to include("jqyi")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jean-Rene Lisnard" do
      before { @code_array = PlayersHelper.name_to_code("Jean-Rene Lisnard") }

      it "should match codes" do
        expect(@code_array).to include("jrlis")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Jo-Wilfried Tsonga" do
      before { @code_array = PlayersHelper.name_to_code("Jo-Wilfried Tsonga") }

      it "should match codes" do
        expect(@code_array).to include("jwtso")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Kerry-Anne Guse" do
      before { @code_array = PlayersHelper.name_to_code("Kerry-Anne Guse") }

      it "should match codes" do
        expect(@code_array).to include("kagus")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Kai-Chen Chang" do
      before { @code_array = PlayersHelper.name_to_code("Kai-Chen Chang") }

      it "should match codes" do
        expect(@code_array).to include("kccha")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Leigh-Anne Eldredge" do
      before { @code_array = PlayersHelper.name_to_code("Leigh-Anne Eldredge") }

      it "should match codes" do
        expect(@code_array).to include("laeld")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Lars-Anders Wahlgren" do
      before { @code_array = PlayersHelper.name_to_code("Lars-Anders Wahlgren") }

      it "should match codes" do
        expect(@code_array).to include("lawah")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Luis-Enrique Herrera" do
      before { @code_array = PlayersHelper.name_to_code("Luis-Enrique Herrera") }

      it "should match codes" do
        expect(@code_array).to include("leher")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Li-Ling Chen" do
      before { @code_array = PlayersHelper.name_to_code("Li-Ling Chen") }

      it "should match codes" do
        expect(@code_array).to include("llche")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Marcos-Aurelio Gorriz-Bonhora" do
      before { @code_array = PlayersHelper.name_to_code("Marcos-Aurelio Gorriz-Bonhora") }

      it "should match codes" do
        expect(@code_array).to include("magor")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Miguel-Angel Lopez Jaen" do
      before { @code_array = PlayersHelper.name_to_code("Miguel-Angel Lopez Jaen") }

      it "should match codes" do
        expect(@code_array).to include("malop")
        expect(@code_array).to include("malja")
        expect(@code_array.length).to eq(2)
      end
    end

    describe "concats Maria-Alejandra Vento" do
      before { @code_array = PlayersHelper.name_to_code("Maria-Alejandra Vento") }

      it "should match codes" do
        expect(@code_array).to include("maven")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Marie-Christine Calleja" do
      before { @code_array = PlayersHelper.name_to_code("Marie-Christine Calleja") }

      it "should match codes" do
        expect(@code_array).to include("mccal")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Maria-Christine Damas" do
      before { @code_array = PlayersHelper.name_to_code("Maria-Christine Damas") }

      it "should match codes" do
        expect(@code_array).to include("mcdam")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Maria-Elena Camerin" do
      before { @code_array = PlayersHelper.name_to_code("Maria-Elena Camerin") }

      it "should match codes" do
        expect(@code_array).to include("mecam")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Marie-Eve Pelletier" do
      before { @code_array = PlayersHelper.name_to_code("Marie-Eve Pelletier") }

      it "should match codes" do
        expect(@code_array).to include("mepel")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Maria-Emilia Salerni" do
      before { @code_array = PlayersHelper.name_to_code("Maria-Emilia Salerni") }

      it "should match codes" do
        expect(@code_array).to include("mesal")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Maria-Francesca Bentivoglio" do
      before { @code_array = PlayersHelper.name_to_code("Maria-Francesca Bentivoglio") }

      it "should match codes" do
        expect(@code_array).to include("mfben")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Marie-Gayanay Mikaelian" do
      before { @code_array = PlayersHelper.name_to_code("Marie-Gayanay Mikaelian") }

      it "should match codes" do
        expect(@code_array).to include("mgmik")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Maria-Jose Gaidano" do
      before { @code_array = PlayersHelper.name_to_code("Maria-Jose Gaidano") }

      it "should match codes" do
        expect(@code_array).to include("mjgai")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Marc-Kevin Goellner" do
      before { @code_array = PlayersHelper.name_to_code("Marc-Kevin Goellner") }

      it "should match codes" do
        expect(@code_array).to include("mkgoe")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Mary-Lou Daniels" do
      before { @code_array = PlayersHelper.name_to_code("Mary-Lou Daniels") }

      it "should match codes" do
        expect(@code_array).to include("mldan")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Maria-Luciana Reynares" do
      before { @code_array = PlayersHelper.name_to_code("Maria-Luciana Reynares") }

      it "should match codes" do
        expect(@code_array).to include("mlrey")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Mi-Ra Jeon" do
      before { @code_array = PlayersHelper.name_to_code("Mi-Ra Jeon") }

      it "should match codes" do
        expect(@code_array).to include("mrjeo")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Nan-Nan Liu" do
      before { @code_array = PlayersHelper.name_to_code("Nan-Nan Liu") }

      it "should match codes" do
        expect(@code_array).to include("nnliu")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Pierre-Hugues Herbert" do
      before { @code_array = PlayersHelper.name_to_code("Pierre-Hugues Herbert") }

      it "should match codes" do
        expect(@code_array).to include("phher")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Paul-Henri Mathieu" do
      before { @code_array = PlayersHelper.name_to_code("Paul-Henri Mathieu") }

      it "should match codes" do
        expect(@code_array).to include("phmat")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Reka-Luca Jani" do
      before { @code_array = PlayersHelper.name_to_code("Reka-Luca Jani") }

      it "should match codes" do
        expect(@code_array).to include("rljan")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Shirli-Ann Siddall" do
      before { @code_array = PlayersHelper.name_to_code("Shirli-Ann Siddall") }

      it "should match codes" do
        expect(@code_array).to include("sasid")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Sung-Hee Park" do
      before { @code_array = PlayersHelper.name_to_code("Sung-Hee Park") }

      it "should match codes" do
        expect(@code_array).to include("shpar")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Shi-Ting Wang" do
      before { @code_array = PlayersHelper.name_to_code("Shi-Ting Wang") }

      it "should match codes" do
        expect(@code_array).to include("stwan")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Su-Wei Hsieh" do
      before { @code_array = PlayersHelper.name_to_code("Su-Wei Hsieh") }

      it "should match codes" do
        expect(@code_array).to include("swhsi")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Tian-Tian Sun" do
      before { @code_array = PlayersHelper.name_to_code("Tian-Tian Sun") }

      it "should match codes" do
        expect(@code_array).to include("ttsun")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Yen-Hsun Lu" do
      before { @code_array = PlayersHelper.name_to_code("Yen-Hsun Lu") }

      it "should match codes" do
        expect(@code_array).to include("yhlu")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Yong-Il YooN" do
      before { @code_array = PlayersHelper.name_to_code("Yong-Il YooN") }

      it "should match codes" do
        expect(@code_array).to include("yiyoo")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Yung-Jan Chan" do
      before { @code_array = PlayersHelper.name_to_code("Yung-Jan Chan") }

      it "should match codes" do
        expect(@code_array).to include("yjcha")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Yong-Min KWon" do
      before { @code_array = PlayersHelper.name_to_code("Yong-Min KWon") }

      it "should match codes" do
        expect(@code_array).to include("ymkwo")
        expect(@code_array.length).to eq(1)
      end
    end

    describe "concats Ying-Ying Duan" do
      before { @code_array = PlayersHelper.name_to_code("Ying-Ying Duan") }

      it "should match codes" do
        expect(@code_array).to include("yydua")
        expect(@code_array.length).to eq(1)
      end
    end
  end
end
