class GossipsController < ApplicationController

  before_action :connected_user, only: [:new, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
    params[:potins] = Potin.all
  end

  def show
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    @gossip = Potin.find(params[:id])
  end

  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
    id = current_user.id
    @gossip = Potin.new(title: params[:title], content: params[:content], user_id: id)

    if @gossip.save
      flash[:success] = "Votre potin a bien été enregistré!"
      redirect_to root_path
    else
      flash[:fail] = "Une erreur s'est produite!!"
      render 'new'
    end

  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @gossip = Potin.find(params[:id])
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    @gossip = Potin.find(params[:id])
    
    if @gossip.update(title: params[:title], content: params[:content])
      flash[:success] = "Votre potin a bien été mis à jour!"
      redirect_to root_path
    else
      flash[:fail] = "Une erreur s'est produite!!"
      render edit
    end

  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
    @gossip = Potin.find(params[:id])
    @gossip.destroy
    flash[:destroy] = "Le potin a bien été supprimé"
    redirect_to root_path
  end

  private

  def connected_user
    if session[:user_id].nil?
      flash[:loggin_needed] = "Please log in."
      redirect_to root_path
    end
  end

  def authenticate_user
    if current_user.id != Potin.find(params[:id]).user_id
      flash[:bad_user] = "Please log in."
      redirect_to root_path
    end
  end

end