module CliProject::Findable

    def find_by_name(name)
        self.all.find {|object| object.name == name}
    end

    def find_by_url(url)
        self.all.find {|object| object.url == url}
    end

    def find_or_create_by_name(name)
        find_by_name(name) || object = self.create(name)
    end

    
end