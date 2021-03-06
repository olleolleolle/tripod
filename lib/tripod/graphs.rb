# encoding: utf-8

# This module defines behaviour for resources with data across multiple graphs
module Tripod::Graphs
  extend ActiveSupport::Concern

  def graphs
    select_query = "SELECT DISTINCT ?g WHERE { GRAPH ?g {<#{uri.to_s}> ?p ?o } }"
    result = Tripod::SparqlClient::Query.select(select_query)

    if result.length > 0
       result.select{|r| r.keys.length > 0 }.map{|r| r["g"]["value"] }
    else
       []
    end
  end
end
