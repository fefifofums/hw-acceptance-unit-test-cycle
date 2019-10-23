describe MoviesController, type: :controller do
    
    context 'create' do
        it 'should call the model method that creates a movie' do
            fake_movie =  double(title: "m21", rating: "R", description: "heoolo", release_date: "10354", director: "m")
            post :create, movie: {title: fake_movie.title}
            expect(flash[:notice]).to eq("#{fake_movie.title} was successfully created.")
            expect(response).to redirect_to(movies_path)
        end
    end
    
    context 'index' do
        it 'should call the model method index' do
            get :index
            expect(response.status).to eq(200)
        end
        
        it 'should call the model method index and sort by title' do
            Movie.create!(title: "m1", director: "m", rating: "R")
            get :index, :sort => 'title'
            controller.params[:sort].should_not be_nil
            controller.params[:sort].should eql 'title'
        end
        
        it 'should call the model method index and sort by release date' do
            Movie.create(title: "m1", director: "m", release_date: "123123")
            get :index, :sort => 'release_date'
            controller.params[:sort].should_not be_nil
            controller.params[:sort].should eql 'release_date'
        end
    end
    
    context 'edit' do
        it 'should call the model method edit' do
            movie1 = Movie.create(title: "m1", director: "m")
            movie2 = Movie.create(title: "m2", director: "m")
            get  :edit, {id: "1"}
            expect(Movie.find("1")).to eq(movie1)
            
        end
    end
    
    context 'show' do
        it 'should call the model method show' do
            movie1 = Movie.create(title: "m1", director: "m")
            movie2 = Movie.create(title: "m2", director: "m")
            get  :show, {id: "2"}
            expect(Movie.find("2")).to eq(movie2)
        end
    end
    
    context 'destroy' do
        it 'should call the model method destroy' do
            movie1 = Movie.create(title: "m1")
            Movie.create(title: "m1", director: "m")
            delete  :destroy, {id: "1"}
            expect(flash[:notice]).to eq("Movie '#{movie1.title}' deleted.")
            expect(response).to redirect_to(movies_path)
        end
    end
    
    context 'movie has no director' do
        it 'should call the model method same_director' do
            movie1 = Movie.create(title: "m1")
            get  :same_director, {id: "1"}
            expect(flash[:notice]).to eq("'#{movie1.title}' has no director info")
            expect(response).to redirect_to(movies_path)
        end
    end
end