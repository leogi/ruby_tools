# Rot_n la thuat toan thay the ki tu thanh ki tu cach do n vi tri theo thu tu alphabet
# ex Rot 23: ABCDEFGHIJKLMNOPQRSTUVWXYZ
#            XYZABCDEFGHIJKLMNOPQRSTUVW
# encrypt: R_n(x) = (x + n) mod 26
# decrypt: R_n(x) = (x - n) mod 26

module Algorithm
  class Rot
    $downcase_characters = "abcdefghijklmnopqrstuvwxyz"
    $upcase_characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    class << self
      def encrypt weight, text
        rot_crypt weight, text
      end

      def decrypt weight, text
        rot_crypt weight, text, false
      end
      
      def caesar_bruteforce text, encrypt = true
        results = {}
        (1..25).each do |weight|
          results.merge!(weight => (encrypt ? encrypt(weight, text) : decrypt(weight, text)))
        end
        results
      end

      private
      def rot_crypt weight, text, encrypt = true
        result = ""
        (0..(text.length - 1)).each do |i|
          result << rot_of(weight, text[i], encrypt)
        end
        result        
      end

      def rot_of weight, char, encrypt = true
        operator = encrypt ? 1 : -1
        index = index_of char
        if index != -1
          rot_characters(char)[((index + weight * operator) % 26).abs]
        else
          char
        end
      end
      
      def index_of char
        if downcase_char? char
          $downcase_characters.index(char)
        elsif upcase_char? char
          $upcase_characters.index(char)
        else
          -1
        end
      end
      
      def rot_characters char
        if downcase_char? char
          $downcase_characters
        elsif upcase_char? char
          $upcase_characters
        else
          []
        end
      end
      
      def downcase_char? char
        char >= "a" && char <= "z"
      end
      
      def upcase_char? char
        char >= "A" && char <= "Z"
      end
    end
  end
end
