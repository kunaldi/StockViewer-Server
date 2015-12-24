module StockViewer
  class StockAPI < Grape::API
    resource :stocks do
      desc 'Return all stocks'
      get do
        if params.has_key? :filter
          { stocks: Stock.where(name: /^#{params.filter.name}.*/i) }
        else
          { stocks: Stock.all }
        end
      end

      desc 'Return a stock by symbol.'
      params { requires :symb, type: String }
      get ':symb' do
        # This doesn't do much here since symbols are already unique and indexed instead of id lookup
        stock = Stock.find_by symb: params[:symb].upcase

        yahoo_client = YahooFinance::Client.new
        data = yahoo_client.historical_quotes(stock.symb, { start_date: Time::now-(24*60*60*30), end_date: Time::now })
        { stock: stock, meta: { history: data }}
      end

    end
  end
end