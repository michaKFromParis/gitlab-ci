class Network
  include HTTParty

  def authenticate url, api_opts
    opts = {
      body: api_opts.to_json,
      headers: {"Content-Type" => "application/json"},
    }

    response = self.class.post(url + api_prefix + 'session.json', opts)

    if response.code == 201
      response.parsed_response
    else
      nil
    end
  end

  def projects url, api_opts
    opts = {
      query: api_opts.merge(per_page: 1000),
      headers: {"Content-Type" => "application/json"},
    }

    response = self.class.get(url + api_prefix + 'projects/owned.json', opts)

    if response.code == 200
      response.parsed_response
    else
      nil
    end
  end

  def add_deploy_key(url, project_id, api_opts)
    opts = {
      body: api_opts.to_json,
      headers: {"Content-Type" => "application/json"},
    }

    response = self.class.post(url + api_prefix + "projects/#{project_id}/keys.json", opts)

    if response.code == 201
      response.parsed_response
    else
      nil
    end
  end

  private

  def api_prefix
    '/api/v3/'
  end
end