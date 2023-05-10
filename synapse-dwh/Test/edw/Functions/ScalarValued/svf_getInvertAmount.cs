using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace Test.edw.Functions.ScalarValued
{
    [TestClass()]
    public class svf_getInvertAmount : SqlDatabaseTestClass
    {

        public svf_getInvertAmount()
        {
            InitializeComponent();
        }

        [TestInitialize()]
        public void TestInitialize()
        {
            base.InitializeTest();
        }
        [TestCleanup()]
        public void TestCleanup()
        {
            base.CleanupTest();
        }

        #region Designer support code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction checkGetInvertAmount_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(svf_getInvertAmount));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition checksumConditionZCR;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition checksumConditionZCRMinus;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition checksumConditionZCR2;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition checksumConditionZCI;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition checksumConditionOther;
            this.checkGetInvertAmountData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            checkGetInvertAmount_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            checksumConditionZCR = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition();
            checksumConditionZCRMinus = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition();
            checksumConditionZCR2 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition();
            checksumConditionZCI = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition();
            checksumConditionOther = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.ChecksumCondition();
            // 
            // checkGetInvertAmount_TestAction
            // 
            checkGetInvertAmount_TestAction.Conditions.Add(checksumConditionZCR);
            checkGetInvertAmount_TestAction.Conditions.Add(checksumConditionZCRMinus);
            checkGetInvertAmount_TestAction.Conditions.Add(checksumConditionZCR2);
            checkGetInvertAmount_TestAction.Conditions.Add(checksumConditionZCI);
            checkGetInvertAmount_TestAction.Conditions.Add(checksumConditionOther);
            resources.ApplyResources(checkGetInvertAmount_TestAction, "checkGetInvertAmount_TestAction");
            // 
            // checksumConditionZCR
            // 
            checksumConditionZCR.Checksum = "446625033";
            checksumConditionZCR.Enabled = true;
            checksumConditionZCR.Name = "checksumConditionZCR";
            // 
            // checksumConditionZCRMinus
            // 
            checksumConditionZCRMinus.Checksum = "-873310206";
            checksumConditionZCRMinus.Enabled = true;
            checksumConditionZCRMinus.Name = "checksumConditionZCRMinus";
            // 
            // checkGetInvertAmountData
            // 
            this.checkGetInvertAmountData.PosttestAction = null;
            this.checkGetInvertAmountData.PretestAction = null;
            this.checkGetInvertAmountData.TestAction = checkGetInvertAmount_TestAction;
            // 
            // checksumConditionZCR2
            // 
            checksumConditionZCR2.Checksum = "446625033";
            checksumConditionZCR2.Enabled = true;
            checksumConditionZCR2.Name = "checksumConditionZCR2";
            // 
            // checksumConditionZCI
            // 
            checksumConditionZCI.Checksum = "446625033";
            checksumConditionZCI.Enabled = true;
            checksumConditionZCI.Name = "checksumConditionZCI";
            // 
            // checksumConditionOther
            // 
            checksumConditionOther.Checksum = "-873310206";
            checksumConditionOther.Enabled = true;
            checksumConditionOther.Name = "checksumConditionOther";
        }

        #endregion


        #region Additional test attributes
        //
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        #endregion

        [TestMethod()]
        public void checkGetInvertAmount()
        {
            SqlDatabaseTestActions testActions = this.checkGetInvertAmountData;
            // Execute the pre-test script
            // 
            System.Diagnostics.Trace.WriteLineIf((testActions.PretestAction != null), "Executing pre-test script...");
            SqlExecutionResult[] pretestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PretestAction);
            try
            {
                // Execute the test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.TestAction != null), "Executing test script...");
                SqlExecutionResult[] testResults = TestService.Execute(this.ExecutionContext, this.PrivilegedContext, testActions.TestAction);
            }
            finally
            {
                // Execute the post-test script
                // 
                System.Diagnostics.Trace.WriteLineIf((testActions.PosttestAction != null), "Executing post-test script...");
                SqlExecutionResult[] posttestResults = TestService.Execute(this.PrivilegedContext, this.PrivilegedContext, testActions.PosttestAction);
            }
        }

        private SqlDatabaseTestActions checkGetInvertAmountData;
    }
}
