unit RouteHandlerImpl;

interface

uses
    RequestIntf,
    ResponseIntf,
    MiddlewareIntf,
    MiddlewareCollectionIntf,
    MiddlewareCollectionAwareIntf,
    RouteHandlerIntf;

type
    {------------------------------------------------
     base class for route handler
     @author Zamrony P. Juhara <zamronypj@yahoo.com>
    -----------------------------------------------}
    TRouteHandler = class(TInterfacedObject, IRouteHandler, IMiddlewareCollectionAware)
    private
        beforeMiddlewareList : IMiddlewareCollection;
        afterMiddlewareList : IMiddlewareCollection;
    public
        constructor create(
            const beforeMiddlewares : IMiddlewareCollection;
            const afterMiddlewares : IMiddlewareCollection
        );
        destructor destroy(); override;
        function addBeforeMiddleware(const middleware : IMiddleware) : IMiddlewareCollectionAware;
        function addAfterMiddleware(const middleware : IMiddleware) : IMiddlewareCollectionAware;
        function getMiddlewares() : IMiddlewareCollectionAware;
        function getBeforeMiddlewares() : IMiddlewareCollection;
        function getAfterMiddlewares() : IMiddlewareCollection;
        function handleRequest(
            const request : IRequest;
            const response : IResponse
        ) : IResponse; virtual; abstract;
    end;

implementation

    constructor TRouteHandler.create(
        const beforeMiddlewares : IMiddlewareCollection;
        const afterMiddlewares : IMiddlewareCollection
    );
    begin
        beforeMiddlewareList := beforeMiddlewares;
        afterMiddlewareList := afterMiddlewares;
    end;

    destructor TRouteHandler.destroy();
    begin
        inherited destroy();
        beforeMiddlewareList := nil;
        afterMiddlewareList := nil;
    end;

    function TRouteHandler.addBeforeMiddleware(const middleware : IMiddleware) : IMiddlewareCollectionAware;
    begin
        beforeMiddlewareList.add(middleware);
        result := self;
    end;

    function TRouteHandler.addAfterMiddleware(const middleware : IMiddleware) : IMiddlewareCollectionAware;
    begin
        afterMiddlewareList.add(middleware);
        result := self;
    end;

    function TRouteHandler.getBeforeMiddlewares() : IMiddlewareCollection;
    begin
        result := beforeMiddlewareList;
    end;

    function TRouteHandler.getAfterMiddlewares() : IMiddlewareCollection;
    begin
        result := afterMiddlewareList;
    end;

    function TRouteHandler.getMiddlewares() : IMiddlewareCollectionAware;
    begin
        result := self;
    end;

end.
