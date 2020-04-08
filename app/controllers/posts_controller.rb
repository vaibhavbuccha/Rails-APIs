class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    begin
      @posts = Post.page(params[:page] || 1).per(params[:per_page_post] || 10) # check for then page params if not available than give page1
      set_pagination_headers(@posts)
      @count = Post.count


      @data = {
        'message' => "Success",
        'total posts' => @count,
        'data' => @posts
      }
      render json:@data , status: 200
    rescue
      raise "No Posts Find"
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    begin
      @post = Post.find(params[:id])
      if @post?
        render json:
      else
        data = {
          'error' => "post unavailable"
        }
        render json:data , status: 404
      end
    rescue Exception => @e

    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    
    if @post.save
      render :show, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      render :show, status: :ok, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :image)
    end

    def set_pagination_headers(pc)
      response.headers['x-Total-count'] = pc.total_count
      links = []
      links << page_link(pc.next_page,'next page') if pc.next_page
      links << page_link(pc.prev_page,'previous page') if pc.prev_page
      links << page_link(pc.total_pages,'last page') unless pc.last_page?

      response.headers['Link'] = links.join(', ') if links.present?

    end

    def page_link(page,rel)
      "<#{posts_url(request.query_parameters.merge(page: page))}>; rel='#{rel}'"
    end

end
