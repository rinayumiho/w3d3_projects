require 'set'

class WordChainer
    def initialize
        @dict = Set.new
        read_from_file
        @graph = Hash.new { |h, k| h[k] = [] }
        create_graph
    end

    def read_from_file
        File.open("dictionary.txt", "r") do |file|
            file.each_line { |line| @dict << line.chomp }
        end
    end

    def create_graph
        @dict.each do |cur|
            len = cur.length
            arr = cur.split("")
            (0...len).each do |i|
                origin = arr[i]
                ("a".."z").each do |ch|
                    next if ch == origin
                    arr[i] = ch
                    adj = arr.join
                    @graph[cur] << adj if @dict.include?(adj)
                end
                arr[i] = origin
            end
        end
    end

    def run(source, target)
        return [] if !@graph.key?(source) || !@graph.key?(target)
        step = bfs(source, target)
        chain = []
        chain << source
        seen = Set.new
        seen << source
        dfs(source, target, chain, step, seen)
        puts chain
    end

    def dfs(cur, target, chain, step, seen)
        return true if cur == target
        return false if step == 0
        @graph[cur].each do |nxt|
            next if seen.include?(nxt)
            seen << nxt
            chain << nxt
            return true if dfs(nxt, target, chain, step - 1, seen)
            seen.delete(nxt)
            chain.pop
        end
        false
    end

    def bfs(source, target)
        seen = Set.new
        queue = Queue.new
        queue << source
        seen << source
        step = 0
        while !queue.empty?
            size = queue.size
            (0...size).each do 
                cur = queue.pop
                return step if cur == target
                @graph[cur].each do |nxt|
                    next if seen.include?(nxt)
                    seen << nxt
                    queue << nxt
                end
            end
            step += 1
        end
        return 0
    end
end

wc = WordChainer.new
wc.run("hit", "cog")