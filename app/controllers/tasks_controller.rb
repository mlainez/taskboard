class TasksController < ApplicationController
  before_filter :login_required
  before_filter :check_permissions
  
  # GET /tasks
  def index
    @tasks = Task.find(:all)
  end

  # GET /tasks/1
  def show
    @task = Task.find(params[:id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
    # Check if a story has been sent as a parameter, if not put a list of stories
    if params[:story]
      @story = Story.find(params[:story]) 
    else
      @stories = Story.find(:all).collect { |story| [story.name, story.id] }
    end 
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  def create
    @task = Task.new(params[:task])
    @task.story = Story.find(params[:story_id])
    @task.status = params[:status]
    if params[:task][:description] == "Description"
      @task.description = ""
    end
    
    if @task.save
      @tasks = Task.tasks_by_status(@task.story,params[:status])
      render :partial => "tasks/tasks_by_status", :locals => { :tasks => @tasks, :new_task => true }
    else
      render :action => "new"
    end
  end

  # PUT /tasks/1
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      if(params[:task][:name])
        render :inline => "#{@task.name}"
      else
        if(params[:task][:description])
          render :inline => "#{@task.description}"
        end
      end
    else
      render :inline => "error"
    end
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @html_id = 'task-' + @task.id.to_s
    if @task.destroy
      render :inline => "<script>Effect.Fade($('#{@html_id}'), {duration: 0.2});</script>", :status => :ok
    else
      render :inline => "", :status => :bad_request
    end
  end
  
  # These functions are used by the taskboard. TODO: See how to avoid them
  def show_form
    @story = Story.find(params[:story])
    @task = Task.new
    render :update do |page|
      page.replace_html "dummy-for-actions", :partial => 'tasks/form', :locals => { :task => @task, :story => @story, :status => params[:status], :x => params[:x],:y => params[:y] }
    end
  end

  def show_edit_task_name_form
    @story = Story.find(params[:story])
    @task = Task.find(params[:id])
    render :update do |page|
      page.replace_html "task-#{@task.id}-name", :partial => 'tasks/edit_task_name', :locals => { :task => @task, :story => @story, :status => params[:status], :x => params[:x],:y => params[:y] }
    end
  end

  def show_edit_task_description_form
    @story = Story.find(params[:story])
    @task = Task.find(params[:id])
    render :update do |page|
      page.replace_html "task-#{@task.id}-description", :partial => 'tasks/edit_task_description', :locals => { :task => @task, :story => @story, :status => params[:status], :x => params[:x],:y => params[:y] }
    end
  end

  def update_task
    @task = Task.find(params[:task])
    @story = Story.find(params[:story])
    old_status = @task.status
    old_story = @task.story
    @task.status = params[:status]
    @task.relative_position_x = params[:x]
    @task.relative_position_y = params[:y]
    @task.story = @story
    if(@task.status == 'finished')
	    @task.remove_tags
    end
    @task.save
    
    # This will be necessary for the update
    @new_status_tasks = Task.tasks_by_status(@task.story,@task.status)
    @old_status_tasks = Task.tasks_by_status(old_story,old_status)

    render :update do |page|
        page.replace_html "#{@task.status}-#{@task.story_id}", :partial => "tasks/tasks_by_status", :locals => { :tasks => @new_status_tasks  } 
        page.replace_html "#{old_status}-#{old_story.id}", :partial => "tasks/tasks_by_status", :locals => { :tasks => @old_status_tasks } 
    end
  end

end
