class Administration::Dosser::V1::PresentationController < ActionController::Base

  clear_helpers

  include Repres::Dosser::Concerns::ResourcePresentation

  layout :nil

end
