require "restzeit.rb"
restzeit= nil
finish= nil
start_time= nil
end_time= nil
text, prefs, output=nil
Shoes.app :title=>"Restzeit", :width=>250, :height=>120 do
  prefs= stack do
    stack :margin => 10 do
      para "Letzter Tag"
      finish = edit_line("2009-02-20 18:30")
    end
    stack :margin => 10 do
      para "Anfangszeit"
      start_time = edit_line("09:30")
    end
    stack :margin => 10 do
      para "Endzeit"
      end_time = edit_line("18:30")
    end
    stack :margin => 10 do
      button "Starten" do
        prefs.hide
        output.show
        restzeit= RestZeit.new(finish.text, start_time.text, end_time.text)
        text.replace restzeit.text, :size=>20
        every(1) do
          restzeit.update
          text.replace restzeit.text, :size=>20
        end
      end
    end
  end
  output= stack(:hidden=>true) do
    stack :margin => 10 do
      text= para ""
    end
    stack :margin => 5 do
      button "Einstellen" do
        output.hide
        prefs.show
      end
    end
  end
end
