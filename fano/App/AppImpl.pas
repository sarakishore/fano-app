unit AppImpl;

interface

uses
   RunnableIntf,
   DependencyContainerIntf,
   AppIntf,
   ConfigIntf,
   DispatcherIntf,
   EnvironmentIntf,
   RouteCollectionIntf,
   RouteHandlerIntf,
   MiddlewareCollectionAwareIntf;

type

    TFanoWebApplication = class(TInterfacedObject, IWebApplication, IRunnable, IRouteCollection)
    private
        config : IAppConfiguration;
        dispatcher : IDispatcher;
        environment : ICGIEnvironment;
        routeCollection :IRouteCollection;
        middlewareList : IMiddlewareCollectionAware;

        function execute() : IRunnable;
    public
        constructor create(
            const cfg : IAppConfiguration;
            const dispatcherInst : IDispatcher;
            const env : ICGIEnvironment;
            const routesInst : IRouteCollection;
            const middlewares : IMiddlewareCollectionAware
        ); virtual;
        destructor destroy(); override;
        function run() : IRunnable;
        function getEnvironment() : ICGIEnvironment;

        //HTTP GET Verb handler
        function get(
            const routeName: string;
            const routeHandler : IRouteHandler
        ) : IRouteCollection;

        //HTTP POST Verb handler
        function post(
            const routeName: string;
            const routeHandler : IRouteHandler
        ) : IRouteCollection;

        //HTTP PUT Verb handler
        function put(
            const routeName: string;
            const routeHandler : IRouteHandler
        ) : IRouteCollection;

        //HTTP PATCH Verb handler
        function patch(
            const routeName: string;
            const routeHandler : IRouteHandler
        ) : IRouteCollection;

        //HTTP DELETE Verb handler
        function delete(
            const routeName: string;
            const routeHandler : IRouteHandler
        ) : IRouteCollection;

        //HTTP HEAD Verb handler
        function head(
            const routeName: string;
            const routeHandler : IRouteHandler
        ) : IRouteCollection;

        //HTTP OPTIONS Verb handler
        function options(
            const routeName: string;
            const routeHandler : IRouteHandler
        ) : IRouteCollection;

        function getMiddlewares() : IMiddlewareCollectionAware;
    end;

implementation

uses
   ResponseIntf,
   ERouteHandlerNotFoundImpl;

    constructor TFanoWebApplication.create(
        const cfg : IAppConfiguration;
        const dispatcherInst : IDispatcher;
        const env : ICGIEnvironment;
        const routesInst : IRouteCollection;
        const middlewares : IMiddlewareCollectionAware
    );
    begin
        config := cfg;
        dispatcher := dispatcherInst;
        environment := env;
        routeCollection := routesInst;
        middlewareList := middlewares;
    end;

    destructor TFanoWebApplication.destroy();
    begin
        inherited destroy();
        config := nil;
        dispatcher := nil;
        environment := nil;
        routeCollection := nil;
        middlewareList := nil;
    end;

    function TFanoWebApplication.execute() : IRunnable;
    var response : IResponse;
        ev : ICGIEnvironment;
    begin
        try
            ev := getEnvironment();
            response := dispatcher.dispatchRequest(ev);
            response.write();
            result := self;
        finally
            response := nil;
            ev := nil;
        end;
    end;

    function TFanoWebApplication.run() : IRunnable;
    begin
        try
            result := execute();
        except
            on e : ERouteHandlerNotFound do
            begin
              //TODO: exception handling
              writeln('Content-Type:text/html');
              writeln();
              writeln(e.message);
            end;
        end;
    end;

    function TFanoWebApplication.getEnvironment() : ICGIEnvironment;
    begin
        result := environment;
    end;

    //HTTP GET Verb handler
    function TFanoWebApplication.get(
        const routeName: string;
        const routeHandler : IRouteHandler
    ) : IRouteCollection;
    begin
       routeCollection.get(routeName, routeHandler);
       result := self;
    end;

    //HTTP POST Verb handler
    function TFanoWebApplication.post(
        const routeName: string;
        const routeHandler : IRouteHandler
    ) : IRouteCollection;
    begin
       routeCollection.post(routeName, routeHandler);
       result := self;
    end;

    //HTTP PUT Verb handler
    function TFanoWebApplication.put(
        const routeName: string;
        const routeHandler : IRouteHandler
    ) : IRouteCollection;
    begin
       routeCollection.put(routeName, routeHandler);
       result := self;
    end;

    //HTTP PATCH Verb handler
    function TFanoWebApplication.patch(
        const routeName: string;
        const routeHandler : IRouteHandler
    ) : IRouteCollection;
    begin
       routeCollection.patch(routeName, routeHandler);
       result := self;
    end;

    //HTTP DELETE Verb handler
    function TFanoWebApplication.delete(
        const routeName: string;
        const routeHandler : IRouteHandler
    ) : IRouteCollection;
    begin
       routeCollection.delete(routeName, routeHandler);
       result := self;
    end;

    //HTTP HEAD Verb handler
    function TFanoWebApplication.head(
        const routeName: string;
        const routeHandler : IRouteHandler
    ) : IRouteCollection;
    begin
       routeCollection.head(routeName, routeHandler);
       result := self;
    end;

    //HTTP HEAD Verb handler
    function TFanoWebApplication.options(
        const routeName: string;
        const routeHandler : IRouteHandler
    ) : IRouteCollection;
    begin
       routeCollection.options(routeName, routeHandler);
       result := self;
    end;

    function TFanoWebApplication.getMiddlewares() : IMiddlewareCollectionAware;
    begin
        result := middlewareList;
    end;
end.
