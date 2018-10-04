unit EnvironmentFactoryImpl;

interface

uses
    EnvironmentFactoryIntf,
    DependencyAwareIntf,
    DependencyContainerIntf,
    DependencyFactoryIntf,
    FactoryImpl;

type
    {------------------------------------------------
     factory class to create class having capability
     to retrieve CGI environment variable

     @author Zamrony P. Juhara <zamronypj@yahoo.com>
    -----------------------------------------------}
    TWebEnvironmentFactory = class(TFactory, IWebEnvironmentFactory, IDependencyFactory)
    public
        function build() : IDependencyAware; override;
    end;

implementation

uses
    EnvironmentImpl;

    function TWebEnvironmentFactory.build() : IDependencyAware;
    begin
        result := TWebEnvironment.create();
    end;

end.