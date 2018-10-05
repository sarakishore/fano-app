unit AppIntf;

interface

uses
    RunnableIntf,
    EnvironmentIntf,
    MiddlewareIntf,
    DependencyContainerIntf;

type

    {------------------------------------------------
     interface for any application
     @author Zamrony P. Juhara <zamronypj@yahoo.com>
    -----------------------------------------------}
    IWebApplication = interface(IRunnable)
        ['{DE7521ED-D26F-4E97-9618-D745D38F0814}']
        function getDependencyContainer() : IDependencyContainer;
        function getEnvironment() : ICGIEnvironment;
        function addMiddleware(const middleware : IMiddleware) : IWebApplication;
    end;

implementation
end.
