require 'jekyll'

# Derives the list of years present in the bibliography so that _pages/publications.md
# does not have to hardcode them. Without this, adding a paper in a year that is not
# already listed renders nothing at all, silently.
#
# Runs before render, so site.data['bib_years'] is available to Liquid.
module PublicationYears
  class Generator < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      scholar = site.config['scholar'] || {}
      path = File.join(site.source,
                       scholar['source'] || '/_bibliography/',
                       scholar['bibliography'] || 'papers.bib')
      return unless File.exist?(path)

      years = File.read(path).scan(/^\s*year\s*=\s*\{?"?(\d{4})"?\}?\s*,?\s*$/).flatten
      site.data['bib_years'] = years.map(&:to_i).uniq.sort.reverse
    end
  end
end
