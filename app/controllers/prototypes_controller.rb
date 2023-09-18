class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # ユーザーがログインしていることを確認します
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @prototypes = Prototype.all
    end
      def new
        @prototype = Prototype.new
      end
    
      def create
        @prototype = current_user.prototypes.build(prototype_params)
        if @prototype.save
          redirect_to root_path, notice: "プロトタイプを投稿しました"
        else
          render :new, status: :unprocessable_entity
        end
      end
      def show
        @prototype = Prototype.find(params[:id])
        @comment = Comment.new
        @comments = @prototype.comments
       
      end
      def edit
        @prototype = Prototype.find(params[:id])
      end
      
      def update
        @prototype = Prototype.find(params[:id])
        if @prototype.update(prototype_params)
          redirect_to prototype_path(@prototype), notice: "プロトタイプを更新しました"
        else
          render :edit, status: :unprocessable_entity
        end
      end
      def destroy
        @prototype = Prototype.find(params[:id])
        if @prototype.destroy
          redirect_to root_path
        else
          redirect_to root_path
        end
      end
    
       
      private
    
      def prototype_params
        params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
      end
      end
    
      def set_prototype
        @prototype = Prototype.find(params[:id])
      end
    
      def contributor_confirmation
        redirect_to root_path unless current_user == @prototype.user
      end
      def correct_user
        @prototype = Prototype.find(params[:id])
        unless current_user == @prototype.user
          redirect_to root_path, alert: 'アクセス権限がありません。' # もしそれらが異なる場合、トップページにリダイレクトします
      end
    end