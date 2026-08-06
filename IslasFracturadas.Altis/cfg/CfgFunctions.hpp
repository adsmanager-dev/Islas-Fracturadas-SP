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

        class Runtime
        {
            file = "core\runtime";
            class runtimeCreate {};
        };

        class Utilities
        {
            file = "core\util";
            class valueClone {};
            class valueIsPersistable {};
        };

        class Errors
        {
            file = "core\errors";
            class errorCreate {};
        };

        class Configuration
        {
            file = "core\config";
            class configLoad {};
            class configValidate {};
        };

        class IDs
        {
            file = "core\ids";
            class validateIds {};
            class idGenerateRuntime {};
        };

        class State
        {
            file = "core\state";
            class stateCreate {};
            class stateValidate {};
            class stateCommandSet {};
            class stateQueryGet {};
        };

        class Events
        {
            file = "core\events";
            class eventSubscribe {};
            class eventPublish {};
            class eventProcess {};
            class eventProcessQueue {};
        };

        class Scheduler
        {
            file = "core\scheduler";
            class schedulerRegister {};
            class schedulerTick {};
        };

        class Transactions
        {
            file = "core\transactions";
            class transactionBegin {};
            class transactionRecord {};
            class transactionCommit {};
            class transactionRollback {};
        };

        class Clock
        {
            file = "core\clock";
            class clockGetStrategicTime {};
            class clockAdvance {};
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
            class m1CoreTest {};
        };
    };
};
