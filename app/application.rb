require "pry"
class Application

    @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]

    def call env
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            resource = req.path.split("/items/").last
            found_item = @@items.find { |item| item.name == resource }
            if found_item

                resp.write "Total price of #{found_item.name} is #{found_item.price}"
                resp.status = 200
                
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else 
            resp.write "Route not found"
            resp.status = 404
        end
        binding.pry
        resp.finish
    end

end 