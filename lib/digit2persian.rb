require "digit2persian/version"

module Digit2persian
  def convert_one_digit(str)
    l_one = {
        "1" => "یک",
        "2" => "دو",
        "3" => "سه",
        "4" => "چهار",
        "5" => "پنج",
        "6" => "شش",
        "7" => "هفت",
        "8" => "هشت",
        "9" => "نه"
    }
      return l_one[str]
  end


  def convert_two_digits(str)


    l_two_one = {
        "10" => "ده",
        "11" => "یازده",
        "12" => "دوازده",
        "13" => "سیزده",
        "14" => "چهارده",
        "15" => "پانزده",
        "16" => "شانزده",
        "17" => "هفده",
        "18" => "هجده",
        "19" => "نوزده"
    }
    l_two_two = {

        "20" => "بیست",
        "30" => "سی",
        "40" => "چهل",
        "50" => "پنجاه",
        "60" => "شصت",
        "70" => "هفتاد",
        "80" => "هشتاد",
        "90" => "نود"
    }


      if l_two_one["#{str}"]
          return l_two_one["#{str}"]
      elsif l_two_two["#{str}"]
          return l_two_two["#{str}"]
      else
          l_two_two.each do |l|
              b = str.to_i - l[0].to_i
              if (b < 10)
                return l[1] + " و " + digits_to_text(b.to_s)
              end
          end
      end
  end


  def convert_three_digits(str)


    l_three = {
        "100" => "صد",
        "200" => "دویست",
        "300" => "سیصد",
        "400" => "چهارصد",
        "500" => "پانصد",
        "600" => "ششصد",
        "700" => "هفتصد",
        "800" => "هشتصد",
        "900" => "نهصد"
    }

      if l_three["#{str}"]
          return l_three["#{str}"]
      else
          l_three.each do |l|
              b = str.to_i - l[0].to_i
              if (b < 100)
                  return l[1] + " و " + digits_to_text(b.to_s)
              end
          end
      end
  end


  def dic_num(n)
    l_one = {
        "1" => "یک",
        "2" => "دو",
        "3" => "سه",
        "4" => "چهار",
        "5" => "پنج",
        "6" => "شش",
        "7" => "هفت",
        "8" => "هشت",
        "9" => "نه"
    }

    l_two_one = {
        "10" => "ده",
        "11" => "یازده",
        "12" => "دوازده",
        "13" => "سیزده",
        "14" => "چهارده",
        "15" => "پانزده",
        "16" => "شانزده",
        "17" => "هفده",
        "18" => "هجده",
        "19" => "نوزده"
    }
    l_two_two = {

        "20" => "بیست",
        "30" => "سی",
        "40" => "چهل",
        "50" => "پنجاه",
        "60" => "شصت",
        "70" => "هفتاد",
        "80" => "هشتاد",
        "90" => "نود"
    }

    l_three = {
        "100" => "صد",
        "200" => "دویست",
        "300" => "سیصد",
        "400" => "چهارصد",
        "500" => "پانصد",
        "600" => "ششصد",
        "700" => "هفتصد",
        "800" => "هشتصد",
        "900" => "نهصد"
    }
    l_four = {
        "1000" => "هزار"
    }
    l_six = {
        "1000000" => "میلیون"
    }
    l_nine = {
        "1000000000" => "میلیارد"
    }
    num_dic = {
        1 => [l_one],
        2 => [l_two_two, l_two_one],
        3 => [l_three],
        4 => [l_four],
        7 => [l_six],
        10 => [l_nine]
    }
      if num_dic[n]
          return num_dic[n]
      else
          if (not num_dic[n])
              n -= 1
              return dic_num(n)
          end
      end
  end


  def digits_to_text(str)
    l_one = {
        "1" => "یک",
        "2" => "دو",
        "3" => "سه",
        "4" => "چهار",
        "5" => "پنج",
        "6" => "شش",
        "7" => "هفت",
        "8" => "هشت",
        "9" => "نه"
    }

      s = str.to_i.to_s
      if s.length == 1
          return convert_one_digit(s)
      elsif s.length == 2
          return convert_two_digits(s)
      elsif s.length == 3
          return convert_three_digits(s)
      else
          n = s.length
          d = dic_num(n)
          d.each do |item|
              if item["#{s}"]
                return num_dic[1][0]["1"] + item["#{s}"]
              else
                  d = d[0]
                  k = (d.keys[0]).to_i
                  d = [k, (d[d.keys[0]]).to_s]
                  s = s.to_i
                  if (s - k) < d[0]
                      return l_one["1"] + " " + d[1] + " و " + digits_to_text((s % k).to_s)
                  else
                      b = s % k
                      if b == 0
                          return digits_to_text((s/k).to_s) + " " + d[1]
                      end
                      return digits_to_text((s/k).to_s) + " " + d[1] + " و " + digits_to_text(b.to_s)
                  end
              end
          end
      end
  end

end
