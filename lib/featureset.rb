module KaruiOshaberi
  class FeatureSet
  include Ramaze

    def initialize
      @user = Current.session[:credential][:user]
      @channel = User[:nick => @user].channel_id
    end

    def missing_method(meth)
      
    end

  end
end

req 'lib/features/init'
