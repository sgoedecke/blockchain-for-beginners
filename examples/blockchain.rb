# This is a Blockchain example app.
require 'digest/md5'
require 'json'

class BlockChain
  def initialize
    @blocks = []
  end

  def blocks
    @blocks
  end

  def add_block(block)
    target_hash = @blocks.last&.to_hash || 'genesis'
    if block.hash == target_hash
      @blocks << block
    end
  end
end

class Block
  def initialize(value, blockchain)
    @content = {
      value: value,
      hash_of_previous_block: blockchain.blocks.last&.to_hash || 'genesis'
    }
  end

  def hash
    @content[:hash_of_previous_block]
  end

  def value
    @content[:value]
  end

  def content
    @content
  end

  def to_hash
    Digest::MD5.hexdigest(@content.to_s)
  end
end

class Client
  def initialize(blockchain)
    @blockchain = blockchain
  end

  def blockchain
    @blockchain
  end

  def write(content)
    new_block = Block.new(content, @blockchain)
    @blockchain.add_block(new_block)
    send_message
  end

  def read
    @blockchain.blocks.map(&:value).join(', ')
  end

  def send_message
    # put your P2P logic here!
    # P2PClient.send(serialize(@blockchain))
  end

  def receive_message(message)
    # more P2P logic!
    # encounter_new_chain(deserialize(message['blockchain'])
  end

  def serialize
    JSON.generate(@blockchain.blocks.map(&:content))
  end

  def deserialize(json)
    new_chain = BlockChain.new
    JSON.parse(json).map do |block|
      new_chain.add_block(Block.new(block["value"], new_chain))
    end
    new_chain
  end

  private

  def encounter_new_chain(new_chain)
    # abandon our chain for the new chain if it's valid and longer than ours
    if is_valid_chain?(new_chain) && (new_chain.blocks.length > @blockchain.blocks.length)
      @blockchain = new_chain
    end
  end

  def is_valid_chain?(new_chain)
    are_hashes_valid?(new_chain) && matches_current_chain?(new_chain)
  end

  def are_hashes_valid?(chain)
    # iterate over the blocks and make sure each block's hash points to the last block
    chain.blocks.reduce do |last_block, block|
      return false if last_block.to_hash != block.hash
      last_block = block
    end
    true
  end

  def matches_current_chain?(chain)
    first_new_block = chain.blocks[0..@blockchain.blocks.length].last
    # since we've already checked if the new chain's hashes are internally consistent,
    # we only need to check that the first block we haven't seen points to our last block.
    @blockchain.blocks.last.to_hash == first_new_block.hash
  end
end
