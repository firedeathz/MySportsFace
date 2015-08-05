require 'test_helper'

class OrganizationsInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:marcos)
		@org = organizations(:exampleorg)
		@article = articles(:clownfiesta)
	end
	
	test "visit organization" do
		log_in_as(@user)
		get organizations_path
		assert_template 'organizations/index'
		assert_select 'ul.og-grid>li>a>span', text: "Example Org"
		get organization_path(@org)
		assert_template 'organizations/show'
	end
	
	test "(un)favorite organization operations" do
		log_in_as(@user)
		get organization_path(@org)
		assert_select "a[href=?]", favorite_organizations_path(organization_id: @org), text: "Add Favorite"
		assert_difference '@user.favorite_organizations.count', 1 do
			post favorite_organizations_path(organization_id: @org)
		end
		assert_redirected_to organization_path(@org)
		follow_redirect!
		assert_not flash.empty?
		assert_select "a[href=?]", favorite_organization_path(@org), text: "Remove Favorite"
		assert_difference '@user.favorite_organizations.count', -1 do
			delete favorite_organization_path(@org)
		end
	end
	
	test "view article, comments and post a new comment" do
		log_in_as(@user)
		get article_path(@article)
		assert_template 'articles/show'
		assert_select "h1", text: @article.title
		assert_select "ul.comments", count: 1
		assert_select "div.comment-div", count: @article.comments.count
		assert_difference '@article.comments.count', 1 do
			post article_comments_path(@article), comment: { author: @user.name, user_id: @user, article_id: @article, body: "new clown fiesta wow" }
		end
	end
	
	test "star and unstar a comment" do
		log_in_as(@user)
		get article_path(@article)
		assert_template 'articles/show'
		comment = @article.comments.first
		assert_difference 'comment.votes_for', 1 do
			post star_comment_path(comment)
		end
		assert_difference 'comment.votes_for', -1 do
			post unstar_comment_path(comment)
		end
	end
	
	test "star and unstar an article" do
		log_in_as(@user)
		get article_path(@article)
		assert_template 'articles/show'
		assert_difference '@article.votes_for', 1 do
			post star_article_path(@article)
		end
		assert_difference '@article.votes_for', -1 do
			post unstar_article_path(@article)
		end
	end

end
