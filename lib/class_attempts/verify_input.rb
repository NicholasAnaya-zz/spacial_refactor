class VerifyInput
  def verify(input)
    if input == "help"
      @help.text
      run #restart run possibility
    elsif input == "search"
      @search
    elsif input == "exit"
      @thank_you = ThankYou.new
      @thank_you.text
      exit

  end
end
