<template>
    <form v-on:submit.prevent>
        <h1 v-if="!editing" class="display-4">New Employee</h1>
        <h1 v-if="editing" class="display-4">Edit Employee</h1>
        <div class="form-group">
            <label>Name</label>
            <input v-model="name" type="text" class="form-control" placeholder="Enter name">
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1">Employee ID</label>
            <input v-model="employeeId" type="number" class="form-control" placeholder="ID">
        </div>
        <button v-on:click="sendForm" type="submit" class="btn btn-primary float-right">Submit</button>
    </form>
</template>

<script>
export default {
    data() {
        return {
            name: '',
            employeeId: null,
            editing: false,
            employee: {}
        }
    },
    props: ['edit'],
    mounted(){
        this.setDataOnEdit()
    },
    methods: {
        sendForm(){
            if(this.editing == true){
                $.ajax({
                    type: 'PUT',
                    url: '/employees/' + this.employee.id,
                    data: { employee: { name: this.name, employee_id: this.employeeId } },
                    error: (err) => {
                        console.log(err)
                    }
                })
            } else {
                if(this.name != '' && this.employeeId != null){
                    $.ajax({
                        type: 'POST',
                        url: '/employees',
                        data: { employee: { name: this.name, employee_id: this.employeeId } },
                        error: (err) => {
                            console.log(err)
                        }
                    })
                }
            }
        },
        setDataOnEdit(){
            if(this.edit != false){
                this.employee = this.edit
                this.name = this.employee.name
                this.employeeId = this.employee.employee_id
                this.editing = true
            }
        }
    }
    
}
</script>