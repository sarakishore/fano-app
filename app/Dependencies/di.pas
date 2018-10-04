{-----------------------------------------------
 Register application dependencies

 @author Zamrony P. Juhara <zamronypj@yahoo.com>
------------------------------------------------}
unit di;

interface

uses
    DependencyAwareIntf,
    DependencyContainerIntf,
    DependencyContainerImpl;

var
    {------------------------------------
    global dependency container instance
    -------------------------------------}
    appDependencyContainer : IDependencyContainer;

implementation

uses
    EnvironmentFactoryImpl,
    DispatcherFactoryImpl,
    RouteCollectionFactoryImpl,
    OutputBufferFactoryImpl,
    ConfigImpl,
    ConfigFactoryImpl,
    DependencyListImpl;

initialization

    appDependencyContainer := TDependencyContainer.create(TDependencyList.create());
    {$INCLUDE main.dependencies.inc}
    {$INCLUDE controllers.dependencies.inc}

finalization
    appDependencyContainer := nil;
end.