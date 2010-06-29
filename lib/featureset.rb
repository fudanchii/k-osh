module KaruiOshaberi
  class FeatureSet

    def initialize(pkg)
      @user = pkg[:user]
      @channel = pkg[:channel]
    end

    def missing_method(meth)
    end

  end
end

req 'lib/features/init'
