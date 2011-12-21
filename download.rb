require 'net/http'

akcje = ["ALL 3", "DWS 3", "SKAR 3", "ALL 1", "CU 1", "NB 4", "UNK 6", "ARKA 3", "CU 3", "IDEA 1", "ING 3", "KAHA 2", "NB 3", "PIO 3", "QUE 1", "SEB 3", "UNK 3"]
pieniadze = ["IDEA 2", "ING 4", "KAHA 4", "NB 2", "PIO 6", "SKAR 4", "UNK 4", "UNK 5"]
obligacje = ["ALL 2", "ARKA 2", "BPH 1", "CU 2", "DWS 2", "ING 2", "KAHA 3", "PIO 2", "SEB 2", "SKAR 2", "UNK 2"]

puts "map = {}"

for i in 0..11

    date = "#{2001 + i/12}-#{1 + i%12}-01"

    res = Net::HTTP.post_form(URI.parse("http://www.skandia.pl/"),
        {'v_print' => '1',
         'order' => 'ASC',
         'column' => 'symbol',
         'v_print' => '',
         'show_full_table' => '',
         'notowania_switch' => '1m',
         'waluta' => '0',
         'menid' => '513',
         'data' => date,
         'mod' => 'notowania',
         's2' => '512'})

    puts "map[\"#{date}\"] = {}"

    for a in akcje+pieniadze+obligacje
        m = res.body.match("^ +<td.*"+a+".*<\/td>\n +<td.*>([0-9]{4}-[0-9]{2}-[0-9]{2})<\/td>\n +<td.*>[^<]+<\/td>\n +<td.*>[^<]+<\/td>\n +<td.*>[^<]+<\/td>\n +<td.*>.+<\/td>\n +<td.*>([^<]+)<\/td>")
#        puts a + " " + date
#        puts $1
#        puts $2
        if $2 == "-"
            puts "#map[\"#{date}\"][\"#{a}\"] = #{$2}"
        else
            puts "map[\"#{date}\"][\"#{a}\"] = #{$2}"
        end
    end

end