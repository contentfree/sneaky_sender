module SneakySender
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      include SneakySender::InstanceMethods
      alias_method_chain :perform_delivery_smtp, :multiple_addresses unless method_defined?(:perform_delivery_smtp_without_multiple_addresses)
    end
  end
  
  module ClassMethods
    # Determine an account number from a range using various strategies.
    #  :random will get a random number within the range
    #  :round_robin goes to the maximum and then loops back around to the start
    def account_number_using_strategy( strategy, account_number_range )
      start              = account_number_range.min
      number_of_accounts = account_number_range.to_a.size

      case strategy.to_sym
      when :random
    	  rand(number_of_accounts).floor + start
  	  when :round_robin
  	    self.current_account_number = start + (((self.current_account_number - start) + 1 ) % number_of_accounts)
      end
    end
  end
  
  module InstanceMethods
    def create_round_robin_accessor_starting_at( number )
      unless self.class.method_defined?(:current_account_number)
        self.class.class_eval <<-EOE
          @@current_account_number = #{number}
          cattr_accessor :current_account_number
        EOE
      end
    end
    
    # Spreads deliveries across multiple email addresses.
    def perform_delivery_smtp_with_multiple_addresses(mail)
      if( multiple_user_names_settings = ActionMailer::Base.smtp_settings[:multiple_user_names] and multiple_user_names_settings.is_a?(Array))
        email_address_template, account_number_range, strategy = multiple_user_names_settings
        strategy ||= :random
        
        if( !email_address_template.blank? && account_number_range.is_a?(Range))
          create_round_robin_accessor_starting_at( account_number_range.min - 1) unless strategy.to_sym != :round_robin
          
          ActionMailer::Base.smtp_settings[:user_name] = email_address_template % self.class.account_number_using_strategy( strategy, account_number_range )
        end
      end
      
      # Perform the actual delivery
      RAILS_DEFAULT_LOGGER.info "Delivering email with #{ActionMailer::Base.smtp_settings[:user_name]}"
      perform_delivery_smtp_without_multiple_addresses(mail)
    end
  end
end

# Mix SneakySender into ActionMailer::Base
ActionMailer::Base.class_eval { include SneakySender }