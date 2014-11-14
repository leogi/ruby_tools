module Algorithm
  class Convert
    
    class << self
      def ascii_to_binary text, decrypt = false
        binaries = []
        (0..text.length - 1).each do |c|
          binaries << text[c].unpack('B*').first
        end
        binaries
      end
      
      def ascii_to_hex text, decrypt = false
        hexs = []
        (0..text.length - 1).each do |c|
          hexs << text[c].unpack('H*')
        end
        hexs
      end

      def hex_to_ascii text, decrypt = false
        [text.split(" ").join("")].pack("H*").force_encoding("utf-8")
      end

      def base64 text, decrypt = true
        !decrypt ? Base64.encode64(text) : Base64.decode64(text)
      end

      def uuencode_uudecode text, decrypt = true
        !decrypt ? [text].pack("u") : text.unpack("u*")
      end
      
      def md5 text, decrypt = false
        Digest::MD5.new.update(text).to_s
      end
    end
  end
end
