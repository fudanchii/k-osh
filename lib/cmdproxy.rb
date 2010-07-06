req 'lib/featureset'

module KaruiOshaberi
  class CmdProxy
    
    def delegate(meth, params)
      return unless method_exists? meth
      lp = @instance.method(meth).arity
      return if params.length < lp
      p = ""
      lp.times do |i|
        p << " params[#{i}]"
        p << "," if i < lp - 1
      end
      eval("@instance.#{meth.to_s}#{p}")
    end

    def initialize
      cid = User[:nick => Ramaze::Current.session[:credential][:user]].channel_id
      chan = Channel[cid]
      @klasses = chan.features
    end
    
    private
    def method_exists?(meth)
      exists = false
      @klasses.each do |klass|
         @instance = KaruiOshaberi::const_get(klass.name).new
         exists = @instance.respond_to? meth
         break if exists
      end
      exists
    end

  end
end
