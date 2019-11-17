<template>
<div>
    <form>
        <h1 class="display-4">New Report</h1>
        <div class="form-group">
            <label>Report Name</label>
            <input v-model="name" type="text" class="form-control" placeholder="Enter the report name">
        </div>
        <div class="form-group">
            <label for="exampleFormControlFile1">Sales Report</label>
            <input type="file" id="file" ref="myFiles" class="form-control-file" 
            @change="submitFile" multiple>
        </div>
    </form>
    <table v-if="submitted" class="table">
        <thead class="thead-dark">
            <tr>
            <th scope="col">Date</th>
            <th scope="col">Hours Worked</th>
            <th scope="col">Employee ID</th>
            <th scope="col">Job Group</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="cs in csv" v-bind:cs="cs" v-bind:key="cs.key">
                <td>{{ cs.date }}</td>
                <td>{{ cs.hours_worked }}</td>
                <td>{{ cs.employee_id }}</td>
                <td>{{ cs.job_group }}</td>
            </tr>
        </tbody>
    </table>
</div>
</template>

<script>
export default {
    data() {
        return {
            csv: [],
            name: '',
            submitted: false
        }
    },
    methods: {
        submitFile(e) {
            const that = this
            const fileToLoad = event.target.files[0]
            const reader = new FileReader()
            reader.onload = fileLoadedEvent => {
                this.$papa.parse(fileLoadedEvent.target.result, {
                    header: true,
                    complete (results) {
                        that.csv = JSON.stringify(results.data).replace(/( +)(?=[(\w* *]*":)/g, "_");
                        that.csv = JSON.parse(that.csv)
                    },
                    error (errors) {
                        console.log('error', errors)
                    }
                })
            }
            reader.readAsText(fileToLoad)
            that.submitted = true
        },
    }
}
</script>

<style lang="scss">
  .dropbox {
    outline: 2px dashed grey; /* the dash box */
    outline-offset: -10px;
    background: lightcyan;
    color: dimgray;
    padding: 10px 10px;
    min-height: 200px; /* minimum height */
    position: relative;
    cursor: pointer;
  }

  .input-file {
    opacity: 0; /* invisible but it's there! */
    width: 100%;
    height: 200px;
    position: absolute;
    cursor: pointer;
  }

  .dropbox:hover {
    background: lightblue; /* when mouse over to the drop zone, change color */
  }

  .dropbox p {
    font-size: 1.2em;
    text-align: center;
    padding: 50px 0;
  }
</style>