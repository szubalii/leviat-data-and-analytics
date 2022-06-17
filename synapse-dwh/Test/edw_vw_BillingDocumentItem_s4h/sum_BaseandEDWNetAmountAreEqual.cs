﻿using Microsoft.Data.Tools.Schema.Sql.UnitTesting;
using Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;

namespace Test
{
    [TestClass()]
    public class sum_BaseandEDWNetAmountAreEqual : SqlDatabaseTestClass
    {

        public sum_BaseandEDWNetAmountAreEqual()
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
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction edw_sp_load_fact_BillingDocumentItemTest_TestAction;
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(sum_BaseandEDWNetAmountAreEqual));
            Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition emptyResultSetCondition1;
            this.edw_sp_load_fact_BillingDocumentItemTestData = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestActions();
            edw_sp_load_fact_BillingDocumentItemTest_TestAction = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.SqlDatabaseTestAction();
            emptyResultSetCondition1 = new Microsoft.Data.Tools.Schema.Sql.UnitTesting.Conditions.EmptyResultSetCondition();
            // 
            // edw_sp_load_fact_BillingDocumentItemTest_TestAction
            // 
            edw_sp_load_fact_BillingDocumentItemTest_TestAction.Conditions.Add(emptyResultSetCondition1);
            resources.ApplyResources(edw_sp_load_fact_BillingDocumentItemTest_TestAction, "edw_sp_load_fact_BillingDocumentItemTest_TestAction");
            // 
            // edw_sp_load_fact_BillingDocumentItemTestData
            // 
            this.edw_sp_load_fact_BillingDocumentItemTestData.PosttestAction = null;
            this.edw_sp_load_fact_BillingDocumentItemTestData.PretestAction = null;
            this.edw_sp_load_fact_BillingDocumentItemTestData.TestAction = edw_sp_load_fact_BillingDocumentItemTest_TestAction;
            // 
            // emptyResultSetCondition1
            // 
            emptyResultSetCondition1.Enabled = true;
            emptyResultSetCondition1.Name = "emptyResultSetCondition1";
            emptyResultSetCondition1.ResultSet = 1;
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
        public void edw_sp_load_fact_BillingDocumentItemTest()
        {
            SqlDatabaseTestActions testActions = this.edw_sp_load_fact_BillingDocumentItemTestData;
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
        private SqlDatabaseTestActions edw_sp_load_fact_BillingDocumentItemTestData;
    }
}
