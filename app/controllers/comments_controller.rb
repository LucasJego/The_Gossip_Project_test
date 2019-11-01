class CommentsController < ApplicationController
 
  before_action :connected_user, only: [:new, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

 def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
  end

  def show
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
  end

  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
    id = current_user.id
    @comment = Comment.new(content: params[:content], user_id: id, potin_id: params[:gossip_id])
    @id = @comment.potin_id
    if @comment.save
      flash[:success] = "Votre commentaire a bien été enregistré!"
      redirect_to gossip_path(@id)
    else
      flash[:fail] = "Une erreur s'est produite!!"
      render 'new'
    end
      
    
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition   
  end

  def update
    @comment = Comment.find(params[:id])
    @id = @comment.potin_id
    @comment = @comment.update(content: params[:content])
    flash[:update] = "Le commentaire a bien été modifié"
    redirect_to gossip_path(@id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @id = @comment.potin_id
    @comment.destroy
    flash[:destroy] = "Le commentaire a bien été supprimé"
    redirect_to gossip_path(@id)
  end

  private

  def connected_user
    if session[:user_id].nil?
      flash[:loggin_needed] = "Please log in."
      redirect_to root_path
    end
  end

  def authenticate_user
    if current_user.id != Comment.find(params[:id]).user_id
      flash[:bad_user] = "Please log in."
      redirect_to root_path
    end
  end

end
