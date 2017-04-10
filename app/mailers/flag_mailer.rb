class FlagMailer < ApplicationMailer
  default from: 'nowyouknowpr@gmail.com'

  def flag_email(flag)
    @flag = flag
    @writer = Writer.find(@flag["writer_id"])
    @reason = @flag["flag_value"]
<<<<<<< HEAD
    @comment = @flag["flag_comment"]
=======
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
    assigned = User.find(@writer.user_id)
    @assigned = assigned.email
    mail(to: 'nowyouknowpr@gmail.com', subject: 'FLAG: '+@writer.f_name+' '+@writer.l_name+' - '+@reason)
  end
<<<<<<< HEAD

=======
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
end
