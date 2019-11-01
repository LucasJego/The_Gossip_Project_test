class UsersController < ApplicationController
	def index
	# Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
	end

	def show
	# Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
		@user = User.find(params[:id])
	end

	def new
		@city = City.all
	end

	def create
	# Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
	# pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
	# Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)

		if params[:city] == "Sélectionner votre ville"
			flash[:fail] = "Une erreur s'est produite!!"
			redirect_to new_user_path
		else
			@user = User.new(first_name: params[:first_name], last_name: params[:last_name], description: params[:description], email: params[:email], age: params[:age], city_id: City.all.find_by(name: params[:city]).id, password: params[:password])

			if params[:password] == params[:repeated_password]
				if @user.save
			      flash[:inscription] = "Vous êtes enregistré"
			      log_in(@user)
			      flash[:login] = 'Login'
			      redirect_to root_path
			    else
			      flash[:fail] = "Une erreur s'est produite!!"
			      redirect_to new_user_path
			    end
			else
				flash[:fail_password] = "Ce n'est pas les mêmes mots de passes"
			    redirect_to new_user_path
			end
		end

	end

	def edit
	# Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
	end

	def update
	# Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
	# pour info, le contenu de ce formulaire sera accessible dans le hash params
	# Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
	end

	def destroy
	# Méthode qui récupère le potin concerné et le détruit en base
	# Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
	end
end
