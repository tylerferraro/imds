RSpec.describe IMDS::Store do
  describe '.initialize' do
    it 'creates an empty hash for storage' do
      store = IMDS::Store.new

      expect(store.send(:data)).to eq({})
    end

    it 'creates a pre-filled hash for storage' do
      data = { a: 'test' }
      store = IMDS::Store.new(data)

      expect(store.send(:data)).to eq(data)
    end
  end

  describe '.get' do
    it 'returns nil if the key does not exist' do
      store = IMDS::Store.new

      expect(store.get(:a)).to be_nil
    end

    it 'returns the stored value at key' do
      value = 'test'
      store = IMDS::Store.new(a: value)

      expect(store.get(:a)).to eq(value)
    end
  end

  describe '.set' do
    it 'stores a value at the specified key' do
      value = 'test'
      store = IMDS::Store.new
      store.set(:a, value)

      expect(store.get(:a)).to eq(value)
    end
  end

  describe '.delete' do
    it 'removes the value stored at the specified key' do
      store = IMDS::Store.new(a: 'test')
      store.delete(:a)

      expect(store.get(:a)).to be_nil
    end
  end

  describe '.count' do
    it 'returns the number of unique keys with matching specified value' do
      data = { a: 'test', b: 'hello', c: 'test' }
      store = IMDS::Store.new(data)

      expect(store.count('test')).to eq(2)
      expect(store.count('hello')).to eq(1)
      expect(store.count('zero')).to eq(0)
    end
  end

  describe '.begin_transactions' do
    it 'creates stacking transactions' do
      store = IMDS::Store.new
      layers = 3

      layers.times { store.begin_transaction }

      expect(store.send(:transactions).length).to eq(layers)
    end
  end

  describe '.rollback' do
    it 'returns the success status of attempting a rollback' do
      store = IMDS::Store.new

      expect(store.rollback).to be(false)

      store.begin_transaction
      expect(store.rollback).to be(true)
    end

    it 'maintains state through multiple transactions' do
      data = { a: 'hello', b: 'world' }
      store = IMDS::Store.new(data)

      store.begin_transaction
      store.set(:a, 'test')
      store.delete(:b)
      store.set(:c, 'none')

      expect(store.get(:a)).to eq('test')
      expect(store.get(:b)).to be_nil
      expect(store.get(:c)).to eq('none')

      store.begin_transaction
      store.set(:b, 'value')
      store.set(:d, 'new')

      expect(store.get(:a)).to eq('test')
      expect(store.get(:b)).to eq('value')
      expect(store.get(:c)).to eq('none')
      expect(store.get(:d)).to eq('new')
  
      store.rollback

      expect(store.get(:a)).to eq('test')
      expect(store.get(:b)).to be_nil
      expect(store.get(:c)).to eq('none')

      store.rollback

      expect(store.get(:a)).to eq('hello')
      expect(store.get(:b)).to eq('world')
      expect(store.get(:c)).to be_nil
    end
  end

  describe '.commit' do
    it 'resets transactions stack' do
      store = IMDS::Store.new
      3.times { store.begin_transaction }
      store.commit

      expect(store.send(:transactions).length).to eq(0)
    end
  end
end