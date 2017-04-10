class FlagMailer < ApplicationMailer
  default from: 'nowyouknowpr@gmail.com'

  def flag_email(flag)
    @flag = flag
    @writer = Writer.find(@flag["writer_id"])
    @reason = @flag["flag_value"]
    @comment = @flag["flag_comment"]
    assigned = User.find(@writer.user_id)
    @assigned = assigned.email
    mail(to: 'nowyouknowpr@gmail.com', subject: 'FLAG: '+@writer.f_name+' '+@writer.l_name+' - '+@reason)
  end
end
