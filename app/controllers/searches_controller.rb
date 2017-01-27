class SearchesController < ApplicationController
  def search
  end


  def foursquare
  	begin 
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = "TXZ3GUCKX2KEU2HKHNKW5OYRIHAGYQ1XMGC4EJVVHX1X000Y"
      req.params['client_secret'] = "KX2QDDGBPPFTWMRRZVKDQVUKRLISGK5RUMKVWLN01Q30R0HH"
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
      req.options.timeout = 10
    end
	  
	  body = JSON.parse(@resp.body)
	  if @resp.success?
	    @venues = body["response"]["venues"]
	  else
	    @error = body["meta"]["errorDetail"]
	  end

	rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
	render 'search'

  end
end
