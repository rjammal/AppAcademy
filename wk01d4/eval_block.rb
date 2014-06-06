
def eval_block(*args, &prc)
  unless block_given?
    puts "NO BLOCK GIVEN!"
  end
  prc.call(*args)
end