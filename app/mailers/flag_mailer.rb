class FlagMailer < ApplicationMailer
  default from: 'nowyouknowpr@gmail.com'

  def flag_email(flag)
    byebug
    @flag = flag
    @writer = Writer.find(@flag["writer_id"])
    @reason = @flag["flag_value"]
    assigned = User.find(@writer.user_id)
    @assigned = assigned.email
    # mail(to: 'nowyouknowpr@gmail.com', subject: 'FLAG: '+@writer.f_name+' '+@writer.l_name+' - '+@reason)
    mail(to: 'stefanhartmann@gmail.com', subject: 'FLAG: '+@writer.f_name+' '+@writer.l_name+' - '+@reason)
  end
end
