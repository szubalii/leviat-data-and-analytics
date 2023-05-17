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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction GetInvertAmount_ZCR_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(svf_getInvertAmount));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction GetInvertAmount_ZCR2_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction GetInvertAmount_ZCI_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction GetInvertAmount_ZCR_Minus_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction GetInvertAmount_Other_TestAction;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition emptyResultSetCondition1;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition emptyResultSetCondition2;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition emptyResultSetCondition3;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition emptyResultSetCondition4;
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition emptyResultSetCondition5;
            this.GetInvertAmount_ZCRData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.GetInvertAmount_ZCR2Data = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.GetInvertAmount_ZCIData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.GetInvertAmount_ZCR_MinusData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            this.GetInvertAmount_OtherData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            GetInvertAmount_ZCR_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            GetInvertAmount_ZCR2_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            GetInvertAmount_ZCI_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            GetInvertAmount_ZCR_Minus_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            GetInvertAmount_Other_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            emptyResultSetCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            emptyResultSetCondition2 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            emptyResultSetCondition3 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            emptyResultSetCondition4 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            emptyResultSetCondition5 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            // 
            // GetInvertAmount_ZCR_TestAction
            // 
            GetInvertAmount_ZCR_TestAction.Conditions.Add(emptyResultSetCondition1);
            resources.ApplyResources(GetInvertAmount_ZCR_TestAction, "GetInvertAmount_ZCR_TestAction");
            // 
            // GetInvertAmount_ZCRData
            // 
            this.GetInvertAmount_ZCRData.PosttestAction = null;
            this.GetInvertAmount_ZCRData.PretestAction = null;
            this.GetInvertAmount_ZCRData.TestAction = GetInvertAmount_ZCR_TestAction;
            // 
            // GetInvertAmount_ZCR2Data
            // 
            this.GetInvertAmount_ZCR2Data.PosttestAction = null;
            this.GetInvertAmount_ZCR2Data.PretestAction = null;
            this.GetInvertAmount_ZCR2Data.TestAction = GetInvertAmount_ZCR2_TestAction;
            // 
            // GetInvertAmount_ZCR2_TestAction
            // 
            GetInvertAmount_ZCR2_TestAction.Conditions.Add(emptyResultSetCondition3);
            resources.ApplyResources(GetInvertAmount_ZCR2_TestAction, "GetInvertAmount_ZCR2_TestAction");
            // 
            // GetInvertAmount_ZCIData
            // 
            this.GetInvertAmount_ZCIData.PosttestAction = null;
            this.GetInvertAmount_ZCIData.PretestAction = null;
            this.GetInvertAmount_ZCIData.TestAction = GetInvertAmount_ZCI_TestAction;
            // 
            // GetInvertAmount_ZCI_TestAction
            // 
            GetInvertAmount_ZCI_TestAction.Conditions.Add(emptyResultSetCondition2);
            resources.ApplyResources(GetInvertAmount_ZCI_TestAction, "GetInvertAmount_ZCI_TestAction");
            // 
            // GetInvertAmount_ZCR_MinusData
            // 
            this.GetInvertAmount_ZCR_MinusData.PosttestAction = null;
            this.GetInvertAmount_ZCR_MinusData.PretestAction = null;
            this.GetInvertAmount_ZCR_MinusData.TestAction = GetInvertAmount_ZCR_Minus_TestAction;
            // 
            // GetInvertAmount_ZCR_Minus_TestAction
            // 
            GetInvertAmount_ZCR_Minus_TestAction.Conditions.Add(emptyResultSetCondition5);
            resources.ApplyResources(GetInvertAmount_ZCR_Minus_TestAction, "GetInvertAmount_ZCR_Minus_TestAction");
            // 
            // GetInvertAmount_OtherData
            // 
            this.GetInvertAmount_OtherData.PosttestAction = null;
            this.GetInvertAmount_OtherData.PretestAction = null;
            this.GetInvertAmount_OtherData.TestAction = GetInvertAmount_Other_TestAction;
            // 
            // GetInvertAmount_Other_TestAction
            // 
            GetInvertAmount_Other_TestAction.Conditions.Add(emptyResultSetCondition4);
            resources.ApplyResources(GetInvertAmount_Other_TestAction, "GetInvertAmount_Other_TestAction");
            // 
            // emptyResultSetCondition1
            // 
            emptyResultSetCondition1.Enabled = true;
            emptyResultSetCondition1.Name = "emptyResultSetCondition1";
            emptyResultSetCondition1.ResultSet = 1;
            // 
            // emptyResultSetCondition2
            // 
            emptyResultSetCondition2.Enabled = true;
            emptyResultSetCondition2.Name = "emptyResultSetCondition2";
            emptyResultSetCondition2.ResultSet = 1;
            // 
            // emptyResultSetCondition3
            // 
            emptyResultSetCondition3.Enabled = true;
            emptyResultSetCondition3.Name = "emptyResultSetCondition3";
            emptyResultSetCondition3.ResultSet = 1;
            // 
            // emptyResultSetCondition4
            // 
            emptyResultSetCondition4.Enabled = true;
            emptyResultSetCondition4.Name = "emptyResultSetCondition4";
            emptyResultSetCondition4.ResultSet = 1;
            // 
            // emptyResultSetCondition5
            // 
            emptyResultSetCondition5.Enabled = true;
            emptyResultSetCondition5.Name = "emptyResultSetCondition5";
            emptyResultSetCondition5.ResultSet = 1;
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
        public void GetInvertAmount_ZCR()
        {
            SqlDatabaseTestActions testActions = this.GetInvertAmount_ZCRData;
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
        [TestMethod()]
        public void GetInvertAmount_ZCR2()
        {
            SqlDatabaseTestActions testActions = this.GetInvertAmount_ZCR2Data;
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
        [TestMethod()]
        public void GetInvertAmount_ZCI()
        {
            SqlDatabaseTestActions testActions = this.GetInvertAmount_ZCIData;
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
        [TestMethod()]
        public void GetInvertAmount_ZCR_Minus()
        {
            SqlDatabaseTestActions testActions = this.GetInvertAmount_ZCR_MinusData;
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
        [TestMethod()]
        public void GetInvertAmount_Other()
        {
            SqlDatabaseTestActions testActions = this.GetInvertAmount_OtherData;
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





        private SqlDatabaseTestActions GetInvertAmount_ZCRData;
        private SqlDatabaseTestActions GetInvertAmount_ZCR2Data;
        private SqlDatabaseTestActions GetInvertAmount_ZCIData;
        private SqlDatabaseTestActions GetInvertAmount_ZCR_MinusData;
        private SqlDatabaseTestActions GetInvertAmount_OtherData;
    }
}
