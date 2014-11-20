module RubyUtils
  class Doc
    @@doc_directory = "./public/ruby/"
    class << self
      def search keyword, options = {}
        query = prepare_query(keyword, options)
        results = `#{query}`
        display_format results
      end

      def search_file keyword, options = {}
        query = search_file_query keyword, options
        results = `#{query}`
        display_format results, true
      end

      def display_format results, filename = false
        results.split("\n").map do |line|
          if filename
            { link: line.gsub("./public", ""), content: line.gsub("./public", "") }
          else
            { link: line.gsub("./public", ""), content: line.gsub("./public", "") }

            # link, content = line.split(".html:")
            # { link: link.gsub("./public", "") + ".html", content: content }
          end
        end   
      end

      def analysis keyword, options = {}
        keyword.split(" ")
      end

      # search keyword
      def prepare_query keyword, options = {}
        words = analysis keyword
        query = "grep -lr -E --include \*.html '>[^<>]*#{words.first}[^<>]*<' #{@@doc_directory}"
        if (length = words.length) > 1
          query += words[1...length].map { |k| "| grep #{k}" }.join(" ")
        end
        query
      end

      # search file name
      def search_file_query keyword, options = {}
        words = analysis keyword 
        query = "find ./public/ruby/ | grep html | grep -E #{words.first}"
        if (length = words.length) > 1
          query += words[1...length].map { |k| "| grep #{k}" }.join(" ")
        end
        query
      end
    end
  end
end
