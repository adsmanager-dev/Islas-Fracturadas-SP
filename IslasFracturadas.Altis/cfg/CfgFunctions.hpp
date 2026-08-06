class CfgFunctions
{
    class IF
    {
        tag = "IF";

        class Bootstrap
        {
            file = "core\bootstrap";
            class bootstrapPreInit { preInit = 1; };
            class bootstrapPostInit { postInit = 1; };
        };

        class Logging
        {
            file = "core\logging";
            class log {};
        };

        class IDs
        {
            file = "core\ids";
            class validateIds {};
        };

        class Diagnostics
        {
            file = "diagnostics";
            class diagnosticsSetMode {};
            class diagnosticsReport {};
        };

        class Tests
        {
            file = "tests";
            class smokeTest {};
        };
    };
};
