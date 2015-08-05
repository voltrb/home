class RubyGemsTask < Volt::Task
  def search_components
    if components_require_load?
      Volt.logger.info('Loading components!')
      cache(fetch_components)
    end
    nil
  end

  private

  def fetch_components page=1
    result = JSON.parse(open("https://rubygems.org/api/v1/search.json\?query\=volt-&page=#{page}").read)
    result += fetch_components(page+1) unless result.empty?
    result.sort { |a,b| a['name'] <=> b['name'] }
  end

  def components_require_load?
    empty_cache? || cache_expired?
  end

  def empty_cache?
    store._rubygems_components.empty?.sync
  end

  def cache_expired?
    store._rubygems_components_updated_at.to_i + 60*60*24 < Time.now.to_i
  end

  def empty_cache!
    store._rubygems_components.reverse.each(&:destroy)
  end

  def cache components
    empty_cache!
    components.each do |component|
      store._rubygems_components.create({
        name: component["name"],
        info: component["info"]
      })
    end
    store._rubygems_components_updated_at = Time.now
  end
end
