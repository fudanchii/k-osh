req 'lib/featureset'

module KaruiOshaberi
  class CmdProxy
    
    def delegate(meth, params)
      return unless method_exists? meth
      lp = @instance.method(meth).arity
      if params.length < lp
        return
      end
      p = ""
      lp.times do |i|
        p << " params[#{i}]"
        p << "," if i < lp - 1
      end
      instance_eval("@instance.#{meth}#{p}")
    end

    def initialize(pkg)
      chan = Channel[:name => pkg[:channel]]
      @attr = pkg
      @klasses = chan.features
    end
    
    private
    def method_exists?(meth)
      exists = false
      @klasses.each do |klass|
         @instance = KaruiOshaberi::const_get(klass.name).new(@attr)
         exists = @instance.respond_to? meth
         break if exists
      end
      exists
    end

  end
end
