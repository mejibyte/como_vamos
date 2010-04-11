require 'spec_helper'

describe JudgesController do

  def mock_judge(stubs={})
    @mock_judge ||= mock_model(Judge, stubs)
  end

  describe "GET index" do
    it "assigns all judges as @judges" do
      Judge.stub(:find).with(:all).and_return([mock_judge])
      get :index
      assigns[:judges].should == [mock_judge]
    end
  end

  describe "GET show" do
    it "assigns the requested judge as @judge" do
      Judge.stub(:find).with("37").and_return(mock_judge)
      get :show, :id => "37"
      assigns[:judge].should equal(mock_judge)
    end
  end

  describe "GET new" do
    it "assigns a new judge as @judge" do
      Judge.stub(:new).and_return(mock_judge)
      get :new
      assigns[:judge].should equal(mock_judge)
    end
  end

  describe "GET edit" do
    it "assigns the requested judge as @judge" do
      Judge.stub(:find).with("37").and_return(mock_judge)
      get :edit, :id => "37"
      assigns[:judge].should equal(mock_judge)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created judge as @judge" do
        Judge.stub(:new).with({'these' => 'params'}).and_return(mock_judge(:save => true))
        post :create, :judge => {:these => 'params'}
        assigns[:judge].should equal(mock_judge)
      end

      it "redirects to the created judge" do
        Judge.stub(:new).and_return(mock_judge(:save => true))
        post :create, :judge => {}
        response.should redirect_to(judge_url(mock_judge))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved judge as @judge" do
        Judge.stub(:new).with({'these' => 'params'}).and_return(mock_judge(:save => false))
        post :create, :judge => {:these => 'params'}
        assigns[:judge].should equal(mock_judge)
      end

      it "re-renders the 'new' template" do
        Judge.stub(:new).and_return(mock_judge(:save => false))
        post :create, :judge => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested judge" do
        Judge.should_receive(:find).with("37").and_return(mock_judge)
        mock_judge.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :judge => {:these => 'params'}
      end

      it "assigns the requested judge as @judge" do
        Judge.stub(:find).and_return(mock_judge(:update_attributes => true))
        put :update, :id => "1"
        assigns[:judge].should equal(mock_judge)
      end

      it "redirects to the judge" do
        Judge.stub(:find).and_return(mock_judge(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(judge_url(mock_judge))
      end
    end

    describe "with invalid params" do
      it "updates the requested judge" do
        Judge.should_receive(:find).with("37").and_return(mock_judge)
        mock_judge.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :judge => {:these => 'params'}
      end

      it "assigns the judge as @judge" do
        Judge.stub(:find).and_return(mock_judge(:update_attributes => false))
        put :update, :id => "1"
        assigns[:judge].should equal(mock_judge)
      end

      it "re-renders the 'edit' template" do
        Judge.stub(:find).and_return(mock_judge(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested judge" do
      Judge.should_receive(:find).with("37").and_return(mock_judge)
      mock_judge.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the judges list" do
      Judge.stub(:find).and_return(mock_judge(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(judges_url)
    end
  end

end
