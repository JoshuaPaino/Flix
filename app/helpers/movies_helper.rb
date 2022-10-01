module MoviesHelper

  
    def total_gross(movie)
        if movie.flop?
          "Flop!"
        else
          number_to_currency(movie.total_gross, precision: 0)
        end
      end

      def year_of(movie)
        movie.released_on.year
      end


        def average_stars(movie)
         if movie.average_stars.zero?
        content_tag(:strong, "No reviews")
        else
          pluralize(movie.average_stars, "star")
        end
    end
end
