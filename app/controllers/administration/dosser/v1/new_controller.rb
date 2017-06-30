class Administration::Dosser::V1::NewController < Administration::Dosser::V1::PresentationController

  def create
    render_ok and return
  end

  def new_attributes
    params.permit(:title, :vice_title, :occurred_at, :classify, :key_words, :content)
  end

  private :new_attributes

end
