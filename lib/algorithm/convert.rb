module Algorithm
  class Convert
    
    class << self
      def ascii_to_binary text, decrypt = false, options = {}
        binaries = []
        (0..text.length - 1).each do |c|
          binaries << text[c].unpack('B*').first
        end
        binaries
      end
      
      def ascii_to_hex text, decrypt = false, options = {}
        hexs = []
        (0..text.length - 1).each do |c|
          hexs << text[c].unpack('H*')
        end
        hexs
      end

      def hex_to_ascii text, decrypt = false, options = {}
        [text.split(" ").join("")].pack("H*").force_encoding("utf-8")
      end

      def base64 text, decrypt = true, options = {}
        !decrypt ? Base64.encode64(text) : Base64.decode64(text)
      end

      def uuencode_uudecode text, decrypt = true, options = {}
        !decrypt ? [text].pack("u") : text.unpack("u*")
      end
      
      def md5 text, decrypt = false, options = {}
        Digest::MD5.new.update(text).to_s
      end

      def html_entities text, decrypt = false, options = {}
        code = HTMLEntities.new
        type = options["type"] || options[:type] || :decimal
        !decrypt ? code.encode(text, type.to_sym) : code.decode(text)
      end
    end
  end
end
