/*
  # Create Notification Triggers

  Create database triggers to automatically queue email notifications
  when certain events occur (new messages, intro calls scheduled, etc.)
*/

-- Trigger to notify expert when client sends a message
CREATE OR REPLACE FUNCTION notify_expert_on_client_message()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.sender = 'client' THEN
    INSERT INTO email_notifications (
      recipient_email,
      notification_type,
      subject,
      body,
      metadata,
      status
    ) 
    SELECT 
      COALESCE(cp.email, 'unknown'),
      'chat_message',
      'New message from client',
      NEW.content,
      jsonb_build_object(
        'client_profile_id', NEW.client_profile_id,
        'expert_id', NEW.expert_id,
        'message_id', NEW.id
      ),
      'pending'
    FROM client_profiles cp
    WHERE cp.id = NEW.client_profile_id;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_notify_expert_message ON messages;
CREATE TRIGGER trigger_notify_expert_message
  AFTER INSERT ON messages
  FOR EACH ROW
  EXECUTE FUNCTION notify_expert_on_client_message();

-- Trigger to notify client when intro call is scheduled
CREATE OR REPLACE FUNCTION notify_client_on_intro_call()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'pending' THEN
    INSERT INTO email_notifications (
      recipient_email,
      notification_type,
      subject,
      body,
      metadata,
      status
    ) VALUES (
      NEW.email,
      'intro_call_scheduled',
      'Your intro call is scheduled',
      'Your intro call has been scheduled.',
      jsonb_build_object(
        'intro_call_id', NEW.id,
        'client_profile_id', NEW.client_profile_id,
        'expert_id', NEW.expert_id
      ),
      'pending'
    );
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_notify_intro_call ON intro_calls;
CREATE TRIGGER trigger_notify_intro_call
  AFTER INSERT ON intro_calls
  FOR EACH ROW
  EXECUTE FUNCTION notify_client_on_intro_call();