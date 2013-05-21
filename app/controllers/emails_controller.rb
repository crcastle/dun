class EmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # Receive email from POST request
  def post
    recipient = params['recipient']
    sender = params['sender']
    from  = params['from']
    subject = params['subject']

    plain_body = params["body-plain"]
    actual_body = params["stripped-text"]

    # This is done synchronously. That should be ok.
    # TODO: make this asynchronous
    process_email_from sender,
                      body: actual_body,
                      sender: sender,
                      from: from,
                      recipient: recipient

    render :text => "OK"
  end

  private

  # Process the email
  def process_email_from(sender, opts={})
    team = lookup_team_from opts[:recipient]
    logger.warn "Unable to find team for #{opts[:recipient]}" if team.nil?

    user = lookup_user_from opts[:sender], opts[:from]
    logger.warn "Unable to find user for #{opts[:sender]} or #{opts[:from]}" if user.nil?

    body = opts[:body]

    body.each_line do |line|
      Sync::Model.enable do
        user.accomplishments.create! title: line, team: team
      end
    end
  end

  # Lookup and return a team based on who the email is sent to
  def lookup_team_from(recipient)
    Team.find_by(name: recipient)
  end

  # Lookup and return a user based on who the email is sent from
  def lookup_user_from(*args)
    emails = []
    args.each do |person|
      # Match a valid email address (not perfect)
      emails << person.match(/\b[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\b/i).to_s
    end

    emails.uniq!
    if emails.count == 1
      return User.find_by email: emails.first
    else
      emails.each do |email|
        u = User.find_by email: email
        return u unless u.nil?
      end
    end

    nil
  end
end
